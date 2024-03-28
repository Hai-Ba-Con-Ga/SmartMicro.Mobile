import 'package:SmartMicro.Mobile/data/account.dart';
import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
    @JsonKey(name: "serialId")
    String? serialId;
    @JsonKey(name: "deviceName")
    String? deviceName;
    @JsonKey(name: "ownerId")
    int? ownerId;
    @JsonKey(name: "owner")
    Account? owner;
    @JsonKey(name: "deviceTypeId")
    int? deviceTypeId;
    @JsonKey(name: "deviceType")
    DeviceType? deviceType;
    @JsonKey(name: "createdDate")
    DateTime? createdDate;

    Device({
        this.serialId,
        this.deviceName,
        this.ownerId,
        this.owner,
        this.deviceTypeId,
        this.deviceType,
        this.createdDate,
    });

    Device copyWith({
        String? serialId,
        String? deviceName,
        int? ownerId,
        Account? owner,
        int? deviceTypeId,
        DeviceType? deviceType,
        DateTime? createdDate,
    }) => 
        Device(
            serialId: serialId ?? this.serialId,
            deviceName: deviceName ?? this.deviceName,
            ownerId: ownerId ?? this.ownerId,
            owner: owner ?? this.owner,
            deviceTypeId: deviceTypeId ?? this.deviceTypeId,
            deviceType: deviceType ?? this.deviceType,
            createdDate: createdDate ?? this.createdDate,
        );

    factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

    Map<String, dynamic> toJson() => _$DeviceToJson(this);
}

@JsonSerializable()
class DeviceType {
    @JsonKey(name: "deviceTypeId")
    int? deviceTypeId;
    @JsonKey(name: "typeName")
    String? typeName;
    @JsonKey(name: "numberOfDevices")
    int? numberOfDevices;

    DeviceType({
        this.deviceTypeId,
        this.typeName,
        this.numberOfDevices,
    });

    DeviceType copyWith({
        int? deviceTypeId,
        String? typeName,
        int? numberOfDevices,
    }) => 
        DeviceType(
            deviceTypeId: deviceTypeId ?? this.deviceTypeId,
            typeName: typeName ?? this.typeName,
            numberOfDevices: numberOfDevices ?? this.numberOfDevices,
        );

    factory DeviceType.fromJson(Map<String, dynamic> json) => _$DeviceTypeFromJson(json);

    Map<String, dynamic> toJson() => _$DeviceTypeToJson(this);
}
