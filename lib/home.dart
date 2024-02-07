import 'package:flutter/material.dart';
import 'dice.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dice()),
          );
        }, child: const Text("Roll Dice"))
      )
    );
  }
}