import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import ''

class SaveDataStore {
  String formatMap(Map<String, dynamic> map, {bool indent = false}) {
    var encoder = JsonEncoder.withIndent(indent ? "  " : null);
    return encoder.convert(jsonDecode(jsonEncode(map)));
  }

  Future<Directory> get localPath async =>
      await getApplicationDocumentsDirectory();

  Future<SaveData> getSaveFile(int number) async {
    assert(number == 3 || number == 2 || number == 1,
        "File number ($number) must be 1, 2, or 3.");

    final path = await localPath;
    return File('$path/save$number.json');
  }

  Future<void> writeData(Map<String, dynamic> dataAsJson, int number) async {
    assert(number == 3 || number == 2 || number == 1,
        "File number ($number) must be 1, 2, or 3.");

    final file = await getSaveFile(number);
    await file.writeAsString(jsonEncode(dataAsJson));
  }

  Future<Map<String, dynamic>> readFile(int number) async {
    assert(number == 3 || number == 2 || number == 1,
        "File number ($number) must be 1, 2, or 3.");
    try {
      final file = await getSaveFile(number);
      var contents = await file.readAsString();
      dynamic parsed = jsonDecode(contents);
      assert(parsed is Map<String, dynamic>,
          "Save data is not valid JSON (file $number):\n$parsed");
      return parsed as Map<String, dynamic>;
    } on Exception catch (error) {
      throw ('Error reading save file $number:\n$error');
    }
  }
}
