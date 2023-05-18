class RegisterResponse {
    bool status;
    String message;
    dynamic accessToken;
    Data? data;

    RegisterResponse({
        required this.status,
        required this.message,
        this.accessToken,
        required this.data,
    });

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"],
        data: json['data'] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "access_token": accessToken,
        "data": data!.toJson(),
    };
}

class Data {
    int id;
    String email;
    String phone;
    String name;
    String password;
    dynamic profilePicture;
    DateTime updatedAt;
    DateTime createdAt;
    String role;

    Data({
        required this.id,
        required this.email,
        required this.phone,
        required this.name,
        required this.password,
        this.profilePicture,
        required this.updatedAt,
        required this.createdAt,
        required this.role,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        password: json["password"],
        profilePicture: json["profile_picture"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "password": password,
        "profile_picture": profilePicture,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "role": role,
    };
}