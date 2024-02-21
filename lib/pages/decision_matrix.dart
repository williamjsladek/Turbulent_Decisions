import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/scenario_provider.dart';
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
      body: Center(
        child: Text(
          context.watch<ScenarioProvider>().userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}