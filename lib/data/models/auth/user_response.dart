class User {
    int id;
    String email;
    String phone;
    String name;
    String? accessToken;

    User({
        required this.id,
        required this.email,
        required this.phone,
        required this.name,
        this.accessToken
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
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