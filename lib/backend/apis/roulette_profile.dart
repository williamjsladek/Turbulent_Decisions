import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:turb_desc/backend/apis/roulette_profiles.dart';

class Profile {
  late String _title;
  late List<String> _options;

  Profile (String title, List<String> options) {
    setTitle(title);
    setOptions(options);
  }

  void setTitle(String title) {
    _title = title;
  }

  void setOptions(List<String> options) {
    if (!options.isEmpty) {
      _options = options;
    }
    _options = [];
  }



}







