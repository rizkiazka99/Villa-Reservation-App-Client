class UserData {
    int id;
    String email;
    String phone;
    String name;
    String? accessToken;

    UserData({
        required this.id,
        required this.email,
        required this.phone,
        required this.name,
        this.accessToken
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        accessToken: json["access_token"] == null ? null : json["access_token"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "access_token": accessToken
    };
}