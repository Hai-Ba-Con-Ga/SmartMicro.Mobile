class Account {
    String? username;
    String? password;
    String? email;
    String? firstName;
    String? lastName;
    DateTime? birthDate;
    int? parentAccountId;
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
}
