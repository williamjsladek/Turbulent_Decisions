import 'package:flutter/material.dart';
import 'package:turb_desc/components/buttons/my_button.dart';

class RouletteInput extends StatelessWidget {
  const RouletteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 120,
        child: Column(children: [
          const TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add new option",
            ),
          ),
          Row(children: [
            MyButton(text: "Save", onPressed: () {}),
            MyButton(text: "Cancel", onPressed: () {})
          ],)
        ],),
      ),
    );
  }
}