import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:turb_desc/components/dialog_boxes/roulette_alert.dart';
import 'package:turb_desc/views/roulette/roulette_tile.dart';
import 'dart:developer';

import '../../components/nav/nav_bar.dart';

class Roulette extends StatefulWidget {
  const Roulette({super.key});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  late TextEditingController controller;
  List<String> _options = [];

  static const IconData autoMode =
      IconData(0xf0787, fontFamily: 'MaterialIcons');

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roulette'),
        elevation: 0,
      ),
      drawer: const NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: spin,
        child: const Icon(autoMode),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: ListView.builder(
                itemCount: _options.length,
                itemBuilder: (context, index) {
                  // *Roulette Tile*
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                          onPressed: ((context) {
                            // delete tile
                            removeOption(_options[index]);
                          }),
                          backgroundColor: Colors.red,
                          icon: Icons.delete,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.indigo,
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          children: [
                            Text(
                              _options[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // *End Roulette Tile*
                }),
          ),
          ElevatedButton(
              onPressed: () async {
                final option = await openDialog();
                if (option == null || option.isEmpty) return;

                addOption(option);
              },
              child: const Icon(Icons.add)),
        ],
      ),
    );
  }

  void removeOption(String option) {
    setState(() {
      _options.remove(option);
    });
  }

  void addOption(String option) {
    setState(() {
      _options.add(option);
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: const Text("Added Option"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Roulette Option'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter Option'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text('SUBMIT'),
            ),
          ],
        ),
      );

  void submit() {
    Navigator.of(context).pop(controller.text);
  }

  void spin() {
    // select a random item from _options and display it to the user
    int randomIndex = Random().nextInt(_options.length);
    showDialog(
      context: context,
      builder: (context) =>
          RouletteAlert(alert: 'Selected:', text: _options[randomIndex]),
    );
  }
}
