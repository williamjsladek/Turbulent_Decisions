import 'dart:io';
import 'package:path_provider/path_provider.dart';


Future<String> get _localPath async {
  final Directory appDocuments = await getApplicationDocumentsDirectory();
  final Directory rouletteDirectory =
    Directory('${appDocuments.path}/roulette');

  if (await rouletteDirectory.exists() == false) {
    await rouletteDirectory.create();
  }

  return rouletteDirectory.path;
}

Future<File> get _profileFile async {
  final path = await _localPath;
  return File('$path/profiles.txt');
}

Future<File> writeTitle(String profile) async {
  final file = await _profileFile;
  return file.writeAsString(profile);
}

Future<List<String>> readProfiles() async {
  try {
    final file = await _profileFile;
    final profiles = await file.readAsLines();
    return profiles;
  } catch (e) {
    return [];
  }
}