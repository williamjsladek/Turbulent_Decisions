import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Find the correct local path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

// Create a reference to the file location
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/counter.txt');
}

// Write data to the file
Future<File> writeCounter(int counter) async {
  final file = await _localFile;

  // Write to file
  return file.writeAsString('$counter');
}

// Read data from the file
Future<int> readCounter() async {
  try {
    final file = await _localFile;
    // Read the file
    final contents = await file.readAsString();
    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}