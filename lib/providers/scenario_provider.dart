import 'package:flutter/material.dart';

class ScenarioProvider extends ChangeNotifier {
  String userName;

  ScenarioProvider({this.userName = "User"});

  void changeUserName({required String newUserName}) async {
    userName = newUserName;
    notifyListeners();
  }
}