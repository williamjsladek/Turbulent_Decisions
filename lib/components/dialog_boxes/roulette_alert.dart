import 'package:flutter/material.dart';
import 'package:turb_desc/components/buttons/my_button.dart';

class RouletteAlert extends StatelessWidget {
  final String alert;
  final String text;

  const RouletteAlert({super.key, required this.alert, required this.text});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      content: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              alert,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            MyButton(
                text: "Acknowledge",
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
