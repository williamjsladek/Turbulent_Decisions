import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dice_icons/dice_icons.dart';
import 'dart:developer';
import '../../flutter_flow/nav/nav_bar.dart';

const List<String> list = <String>["d4", "d6", "d8", "d10", "d12", "d20"];
List<DiceRoll> diceRollList = List.generate(1, (int i) => DiceRoll());

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Dice")),
      drawer: const NavBar(),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           ListView.builder(
             scrollDirection: Axis.vertical,
             shrinkWrap: true,
             itemCount: diceRollList.length,
             itemBuilder: (_, index) => diceRollList[index],
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               ElevatedButton(onPressed: removeDiceField, child: const Icon(Icons.remove)),
               ElevatedButton(onPressed: addDiceField, child: const Icon(Icons.add)),
             ],
           )

         ], 
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: roll,
        child: const Icon(DiceIcons.dice1),
      ),
    );
  }

  void addDiceField() {
    setState(() {});
    diceRollList.add(DiceRoll());
  }

  void removeDiceField() {
    setState(() {});
    if (diceRollList.length > 1) {
      diceRollList.removeLast();
    }
  }

  void roll() {
    for (int i = 0; i < diceRollList.length; i++) {
      log("values: ${diceRollList[i].getNum()}, ${diceRollList[i].getType()}");
    }
  }
}

class DiceRoll extends StatefulWidget {
  DiceRoll ({super.key});
  final _DiceRoll _diceRollState = _DiceRoll();

  @override
  State<StatefulWidget> createState() => _diceRollState;

  String getNum() {
    return _diceRollState.numberOfDice;
  }

  String getType() {
    return _diceRollState.dropDownValue;
  }
}

class _DiceRoll extends State<DiceRoll> {
  String dropDownValue = list.first;
  String numberOfDice = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Num: "),
        SizedBox(
          width: 30,
          child: Form(
            child: TextFormField(
              textAlign: TextAlign.center,
              maxLength: 2,
              onChanged: (String? value) {
                setState(() {
                  numberOfDice = value!;
                });
              },
              decoration: const InputDecoration(
                  counterText: ''
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
        ),
        const Text(" Type: "),
        DropdownMenu<String>(
          initialSelection: list.first,
          onSelected: (String? value) {
            setState(() {
              dropDownValue = value!;
            });
          },
          dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(value: value, label: value);
          }).toList(),
        )
      ],
    );
  }
}
