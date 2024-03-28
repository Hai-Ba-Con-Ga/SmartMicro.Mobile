// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      serialId: json['serialId'] as String?,
      deviceName: json['deviceName'] as String?,
      ownerId: json['ownerId'] as int?,
      owner: json['owner'] == null
          ? null
          : Account.fromJson(json['owner'] as Map<String, dynamic>),
      deviceTypeId: json['deviceTypeId'] as int?,
      deviceType: json['deviceType'] == null
          ? null
          : DeviceType.fromJson(json['deviceType'] as Map<String, dynamic>),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'serialId': instance.serialId,
      'deviceName': instance.deviceName,
      'ownerId': instance.ownerId,
      'owner': instance.owner,
      'deviceTypeId': instance.deviceTypeId,
      'deviceType': instance.deviceType,
      'createdDate': instance.createdDate?.toIso8601String(),
    };

DeviceType _$DeviceTypeFromJson(Map<String, dynamic> json) => DeviceType(
      deviceTypeId: json['deviceTypeId'] as int?,
      typeName: json['typeName'] as String?,
      numberOfDevices: json['numberOfDevices'] as int?,
    );

Map<String, dynamic> _$DeviceTypeToJson(DeviceType instance) =>
    <String, dynamic>{
      'deviceTypeId': instance.deviceTypeId,
      'typeName': instance.typeName,
      'numberOfDevices': instance.numberOfDevices,
    };
