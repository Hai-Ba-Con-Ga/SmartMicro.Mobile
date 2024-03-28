import 'package:json_annotation/json_annotation.dart';
part 'account.g.dart';

@JsonSerializable()
class Account {
    @JsonKey(name: "username")
    String? username;
    @JsonKey(name: "password")
    String? password;
    @JsonKey(name: "email")
    String? email;
    @JsonKey(name: "firstName")
    String? firstName;
    @JsonKey(name: "lastName")
    String? lastName;
    @JsonKey(name: "birthDate")
    DateTime? birthDate;
    @JsonKey(name: "parentAccountId")
    int? parentAccountId;
    @JsonKey(name: "role")
    String? role;

    Account({
        this.username,
        this.password,
        this.email,
        this.firstName,
        this.lastName,
        this.birthDate,
        this.parentAccountId,
        this.role,
    });

    Account copyWith({
        String? username,
        String? password,
        String? email,
        String? firstName,
        String? lastName,
        DateTime? birthDate,
        int? parentAccountId,
        String? role,
    }) => 
        Account(
            username: username ?? this.username,
            password: password ?? this.password,
            email: email ?? this.email,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            birthDate: birthDate ?? this.birthDate,
            parentAccountId: parentAccountId ?? this.parentAccountId,
            role: role ?? this.role,
        );

    factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

    Map<String, dynamic> toJson() => _$AccountToJson(this);
}
