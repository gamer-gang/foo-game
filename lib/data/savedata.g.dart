// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveData _$SaveDataFromJson(Map<String, dynamic> json) {
  return $checkedNew('SaveData', json, () {
    final val = SaveData(
      fileNumber: $checkedConvert(json, 'fileNumber', (v) => v as int),
      level: $checkedConvert(json, 'level', (v) => v as int),
      collectedItems: $checkedConvert(json, 'collectedItems', (v) => v as List),
    );
    return val;
  });
}

Map<String, dynamic> _$SaveDataToJson(SaveData instance) => <String, dynamic>{
      'fileNumber': instance.fileNumber,
      'level': instance.level,
      'collectedItems': instance.collectedItems,
    };
