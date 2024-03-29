// To parse this JSON data, do
//
//     final collectedData = collectedDataFromJson(jsonString);
import 'device.dart';

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'collected_data.g.dart';

CollectedData collectedDataFromJson(String str) => CollectedData.fromJson(json.decode(str) as Map<String, dynamic>);

String collectedDataToJson(CollectedData data) => json.encode(data.toJson());

@JsonSerializable()
class CollectedData {
  @JsonKey(name: "collectedDataId")
  int? collectedDataId;
  @JsonKey(name: "dataValue")
  String? dataValue;
  @JsonKey(name: "dataUnit")
  String? dataUnit;
  @JsonKey(name: "deviceId")
  int? deviceId;
  @JsonKey(name: "device")
  Device? device;
  @JsonKey(name: "typeId")
  int? collectedDataTypeId;
  @JsonKey(name: "collectedDataType")
  CollectedDataType? collectedDataType;
  @JsonKey(name: "createdDate")
  DateTime? createdDate;

  CollectedData({
    this.collectedDataId,
    this.dataValue,
    this.dataUnit,
    this.deviceId,
    this.device,
    this.collectedDataTypeId,
    this.collectedDataType,
    this.createdDate,
  });

  CollectedData copyWith({
    int? collectedDataId,
    String? dataValue,
    String? dataUnit,
    int? deviceId,
    Device? device,
    int? collectedDataTypeId,
    CollectedDataType? collectedDataType,
    DateTime? createdDate,
  }) =>
      CollectedData(
        collectedDataId: collectedDataId ?? this.collectedDataId,
        dataValue: dataValue ?? this.dataValue,
        dataUnit: dataUnit ?? this.dataUnit,
        deviceId: deviceId ?? this.deviceId,
        device: device ?? this.device,
        collectedDataTypeId: collectedDataTypeId ?? this.collectedDataTypeId,
        collectedDataType: collectedDataType ?? this.collectedDataType,
        createdDate: createdDate ?? this.createdDate,
      );

  factory CollectedData.fromJson(Map<String, dynamic> json) => _$CollectedDataFromJson(json);

  Map<String, dynamic> toJson() => _$CollectedDataToJson(this);
}

@JsonSerializable()
class CollectedDataType {
  @JsonKey(name: "collectedDataTypeId")
  int? collectedDataTypeId;
  @JsonKey(name: "dataTypeName")
  String? dataTypeName;

  CollectedDataType({
    this.collectedDataTypeId,
    this.dataTypeName,
  });

  CollectedDataType copyWith({
    int? collectedDataTypeId,
    String? dataTypeName,
  }) =>
      CollectedDataType(
        collectedDataTypeId: collectedDataTypeId ?? this.collectedDataTypeId,
        dataTypeName: dataTypeName ?? this.dataTypeName,
      );

  factory CollectedDataType.fromJson(Map<String, dynamic> json) => _$CollectedDataTypeFromJson(json);

  Map<String, dynamic> toJson() => _$CollectedDataTypeToJson(this);
}
