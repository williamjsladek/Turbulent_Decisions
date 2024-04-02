import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:turb_desc/components/dialog_boxes/roulette_alert.dart';

import 'package:turb_desc/services/firestore.dart';

import '../../backend/apis/roulette_profiles.dart';
import '../../components/nav/nav_bar.dart';

class Roulette extends StatefulWidget {
  const Roulette({super.key});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  // firestore
  final FirestoreService firestoreService = FirestoreService();

  // text controller
  late TextEditingController controller;
  late List<String> _options = [];
  late String _title = '';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final option = await optionInput();
                    if (option == null || option.isEmpty) return;
                    controller.clear();
                    addOption(option);
                  },
                  child: const Icon(Icons.add),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _title = (await titleInput())!;
                    if (_title.isEmpty) return;
                    controller.clear();
                    saveProfile();
                  },
                  child: const Icon(Icons.save),
                ),
                ElevatedButton(
                  onPressed: () => dialoger(context),
                  child: const Text('LOAD'),
                ),
              ],
            ),
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

  Future<String?> optionInput() => showDialog<String>(
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

  Future<String?> titleInput() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.deepPurple[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Profile Title',
            style: TextStyle(color: Colors.white),
          ),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
                hintText: 'Enter Title',
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

  void saveProfile() {
    // Save new profile
    firestoreService.addProfile(_title, _options);
  }

  dynamic dialoger(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('List View'),
          content: SizedBox(
            width: double.maxFinite,
            child: StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getProfileStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List profilesList = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: profilesList.length,
                    itemBuilder: (_, index) {
                      // get each individual doc
                      DocumentSnapshot document = profilesList[index];
                      String docID = document.id;
                      // get profile from each doc
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      String profileName = data['name'];
                      List<String> optionsList = List.from(data['options']);

                      // display as list tile
                      return ListTile(
                        title: Text(profileName),
                        onTap: () {
                          setState(() {
                            _options.clear();
                            optionsList.forEach((element) {
                              _options.add(element);
                            });
                          });
                        },
                      );
                    },
                  );
                }
                throw '';
              }
            ),
          ),
        );
      },
    );
  }

}
