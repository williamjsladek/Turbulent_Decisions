import 'package:flutter/material.dart';
import 'package:turb_desc/components/buttons/my_button.dart';

class RouletteAlert extends StatelessWidget {
  final String alert;
  final String text;

  const RouletteAlert({super.key, required this.alert, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: SizedBox(
        height: 120,
        child: Column(
          children: [
            Text(alert),
            Text(text),
            MyButton(text: "Acknowledge", onPressed: () {
              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }
}
