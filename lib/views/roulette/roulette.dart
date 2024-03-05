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
  final List<String> _options = [];

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
      body: Container(
        color: Colors.deepPurple[300],
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    // *Roulette Tile*
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      margin: const EdgeInsets.all(5.0),
                      child: Slidable(
                        // Delete Option
                        endActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: ((context) {
                                removeOption(_options[index]);
                              }),
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                          ],
                        ),
                        // Option Text
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _options[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
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
      builder: (context) =>
          const RouletteAlert(alert: 'Option Added!', text: ''),
    );
  }

  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.deepPurple[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Roulette Option',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
                hintText: 'Enter Option',
                hintStyle: TextStyle(color: Colors.white)),
            controller: controller,
            style: const TextStyle(color: Colors.white),
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
    controller.clear();
    Navigator.of(context).pop(controller.text);
  }

  void spin() {
    // select a random item from _options and display it to the user
    int randomIndex = Random().nextInt(_options.length);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          RouletteAlert(alert: 'Selected:', text: _options[randomIndex]),
    );
  }
}
