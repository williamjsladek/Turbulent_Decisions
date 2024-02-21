import 'package:flutter/material.dart';
import '../nav_bar.dart';

class DecisionMatrix extends StatefulWidget {
  const DecisionMatrix({super.key});

  @override
  State<DecisionMatrix> createState() => _DecisionMatrixState();
}

class _DecisionMatrixState extends State<DecisionMatrix> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Decision Matrix'),),
      drawer: const NavBar(),
    );
  }
}