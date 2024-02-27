import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> list = <String>["d4", "d6", "d8", "d10", "d12", "d20"];

class Dice extends StatefulWidget {
  const Dice({super.key});

  @override
  _Dice createState() => _Dice();
}

class _Dice extends State<Dice> {
  int diceCount = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> diceRollList = List.generate(diceCount, (int i) => const DiceRoll());
    return Scaffold(
      appBar: AppBar(title: const Text("Rolling Dice")),

      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           ListView(
             scrollDirection: Axis.vertical,
             shrinkWrap: true,
             children: diceRollList,
           ),
           ElevatedButton(onPressed: addDiceField, child: const Icon(Icons.add)),
         ], 
        ),

      )
    );
  }

  void addDiceField() {
    setState(() {
      diceCount += 1;
    });
  }
}

class DiceRoll extends StatefulWidget {
  const DiceRoll ({super.key});

  @override
  State<StatefulWidget> createState() => _DiceRoll();
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