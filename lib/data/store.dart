import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'savedata.dart';

class SaveDataStore {
  String formatMap(Map<String, dynamic> map, {bool indent = false}) {
    var encoder = JsonEncoder.withIndent(indent ? "  " : null);
    return encoder.convert(jsonDecode(jsonEncode(map)));
  }

  Future<Directory> get localDir async =>
      await getApplicationDocumentsDirectory();

  Future<File> getSaveFile(int number) async {
    assert(number == 3 || number == 2 || number == 1,
        "File number ($number) must be 1, 2, or 3.");

    final dir = await localDir;

    print('Application documents directory: ${dir.path}');

    var file = File('${dir.path}/save$number.json');

    if (!file.existsSync()) {
      print('File ${file.path} does not exist, creating it...');
      file.createSync();
    }

    return file;
  }

  Future<void> writeData(Map<String, dynamic> dataAsJson, int number) async {
    assert(number == 3 || number == 2 || number == 1,
        "File number ($number) must be 1, 2, or 3.");

    final file = await getSaveFile(number);
    await file.writeAsString(jsonEncode(dataAsJson));
  }

  Future<SaveData> readFile(int number) async {
    assert(number == 3 || number == 2 || number == 1,
        "File number ($number) must be 1, 2, or 3.");
    // try {
    print("Attempting to read file #$number...");

    final file = await getSaveFile(number);

    print("Got file path ${file.path}, reading contents...");

    var contents = await file.readAsString();

    print('Got contents $contents');

    if (contents.isEmpty) {
      print('File was empty, setting contents to "{}".');
      contents = '{}';
    }

    dynamic parsed = jsonDecode(contents);

    assert(parsed is Map<String, dynamic>,
        "Save data is not valid JSON (file $number):\n$parsed");

    var json = parsed as Map<String, dynamic>;
    var save = SaveData.fromJson(json);

    if (save.level == null) {
      print('Parsed data does not have \'level\' property, '
          'returning default save.');

      return SaveData(
        fileNumber: number,
        level: 1,
        collectedItems: [],
      );
    }

    print('Created SaveData instance.');
    print(save.toString());

    return save;
    // } on Exception catch (error) {
    //   throw ('Error reading save file $number:\n$error');
    // }
  }
}
