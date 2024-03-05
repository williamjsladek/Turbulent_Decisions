import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dice_icons/dice_icons.dart';
import 'dart:developer';

import '../../flutter_flow/nav/nav_bar.dart';

class Roulette extends StatefulWidget {
  const Roulette({super.key});

  @override
  State<Roulette> createState() => _RouletteState();
}

class _RouletteState extends State<Roulette> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Roulette'),),
      drawer: const NavBar(),
    );
  }
}