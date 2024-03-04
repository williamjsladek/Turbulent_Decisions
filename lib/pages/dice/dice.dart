import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dice_icons/dice_icons.dart';
import 'dart:developer';
import '../../flutter_flow/nav/nav_bar.dart';

const List<String> list = <String>["d4", "d6", "d8", "d10", "d12", "d20"];

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int diceCount = 1;
  List<Widget> diceRollList = List.generate(1, (int i) => const DiceRoll());

  @override
  Widget build(BuildContext context) {
    List<Widget> diceRollList = List.generate(diceCount, (int i) => const DiceRoll());
    return Scaffold(
      appBar: AppBar(title: const Text("Dice")),
      drawer: const NavBar(),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           ListView(
             scrollDirection: Axis.vertical,
             shrinkWrap: true,
             children: diceRollList,
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
    setState(() {
      diceCount += 1;
    });
  }

  void removeDiceField() {
    setState(() {
      if (diceCount > 1) {
        diceCount -= 1;
      }
    });
  }

  void roll() {
    log("values: ${diceRollList[0]}");
  }
}

class DiceRoll extends StatefulWidget {
  const DiceRoll ({super.key});

  @override
  State<StatefulWidget> createState() => _DiceRoll();

  int getRoll() {

    return 1;
  }
}

class _DiceRoll extends State<DiceRoll> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Num: "),
        SizedBox(
          width: 30,
          child: NumDiceForm(),
        ),
        Text(" Type: "),
        DropDownDice()
      ],
    );
  }
}

class NumDiceForm extends StatefulWidget {
  const NumDiceForm ({super.key});

  @override
  NumDiceFormState createState() {
    return NumDiceFormState();
  }
}

class NumDiceFormState extends State<NumDiceForm> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: TextField(
        textAlign: TextAlign.center,
        maxLength: 2,
        decoration: const InputDecoration(
          counterText: ''
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      ),
    );
  }
}

class DropDownDice extends StatefulWidget {
  const DropDownDice({super.key});

  @override
  State<DropDownDice> createState() => DropDownDiceState();
}

class DropDownDiceState extends State<DropDownDice> {
  String dropDownValue = list.first;

  @override
  Widget build (BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        setState(() {
          dropDownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry(value: value, label: value);
      }).toList(),
    );
  }
}