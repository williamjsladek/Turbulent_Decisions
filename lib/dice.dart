import 'package:flutter/material.dart';

const List<String> list = <String>["d4", "d6", "d8", "d10", "d12", "d20"];

class Dice extends StatelessWidget {
  const Dice({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rolling Dice")),

      body: const Center(
        child: Text("dice"),
      )
    );
  }
}

class DropDownDice extends StatefulWidget {
  const DropDownDice({super.key});

  @override
  State<DropDownDice> createState() => _DropDownDiceState();
}

class _DropDownDiceState extends State<DropDownDice> {
  String dropDownValue = list.first;

  @override
  Widget build (BuildContext context) {
    return DropdownButton<String>(
      value: dropDownValue,
      onChanged: (String? value) {
        setState(() {
          dropDownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}