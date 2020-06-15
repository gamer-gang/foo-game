// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savedata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveData _$SaveDataFromJson(Map<String, dynamic> json) {
  return $checkedNew('SaveData', json, () {
    final val = SaveData(
      fileNumber: $checkedConvert(json, 'fileNumber', (v) => v as int),
    );
    $checkedConvert(json, 'level', (v) => val.level = v as int);
    $checkedConvert(
        json, 'collectedItems', (v) => val.collectedItems = v as List);
    return val;
  });
}

Map<String, dynamic> _$SaveDataToJson(SaveData instance) => <String, dynamic>{
      'fileNumber': instance.fileNumber,
      'level': instance.level,
      'collectedItems': instance.collectedItems,
    };
