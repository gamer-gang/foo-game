import 'package:json_annotation/json_annotation.dart';

part 'savedata.g.dart';

@JsonSerializable()
class SaveData {
  int fileNumber;
  int level;
  List collectedItems;
  
  SaveData({this.fileNumber});

  factory SaveData.fromJson(Map<String, dynamic> json) =>
      _$SaveDataFromJson(json);
  Map<String, dynamic> toJson() => _$SaveDataToJson(this);
}
