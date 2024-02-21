// packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// providers
import 'providers/scenario_provider.dart';
// pages
import 'pages/home.dart';
import 'pages/roulette.dart';
import 'pages/dice.dart';
import 'pages/decision_matrix.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Turbulent Decisions';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => ScenarioProvider(),
          ),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(title: appTitle),
          '/roulette': (context) => const Roulette(),
          '/dice': (context) => const Dice(),
          '/decision_matrix': (context) => const DecisionMatrix(),
        },
      ),
    );
  }
}

