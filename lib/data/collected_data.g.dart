// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collected_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectedData _$CollectedDataFromJson(Map<String, dynamic> json) =>
    CollectedData(
      collectedDataId: json['collectedDataId'] as int?,
      dataValue: json['dataValue'] as String?,
      dataUnit: json['dataUnit'] as String?,
      deviceId: json['deviceId'] as int?,
      device: json['device'] == null
          ? null
          : Device.fromJson(json['device'] as Map<String, dynamic>),
      collectedDataTypeId: json['typeId'] as int?,
      collectedDataType: json['collectedDataType'] == null
          ? null
          : CollectedDataType.fromJson(
              json['collectedDataType'] as Map<String, dynamic>),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$CollectedDataToJson(CollectedData instance) =>
    <String, dynamic>{
      'collectedDataId': instance.collectedDataId,
      'dataValue': instance.dataValue,
      'dataUnit': instance.dataUnit,
      'deviceId': instance.deviceId,
      'device': instance.device,
      'typeId': instance.collectedDataTypeId,
      'collectedDataType': instance.collectedDataType,
      'createdDate': instance.createdDate?.toIso8601String(),
    };

CollectedDataType _$CollectedDataTypeFromJson(Map<String, dynamic> json) =>
    CollectedDataType(
      collectedDataTypeId: json['collectedDataTypeId'] as int?,
      dataTypeName: json['dataTypeName'] as String?,
    );

Map<String, dynamic> _$CollectedDataTypeToJson(CollectedDataType instance) =>
    <String, dynamic>{
      'collectedDataTypeId': instance.collectedDataTypeId,
      'dataTypeName': instance.dataTypeName,
    };
