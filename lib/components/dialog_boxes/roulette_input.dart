import 'package:flutter/material.dart';
import 'package:turb_desc/components/buttons/my_button.dart';
import 'package:turb_desc/views/roulette/roulette.dart';

class RouletteInput extends StatelessWidget {
  const RouletteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Roulette Option'),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter Option'),
        controller: controller,
      ),
      actions: [
        TextButton(
          onPressed: submit,
          child: const Text('SUBMIT'),
        ),
      ],
    );
  }
}