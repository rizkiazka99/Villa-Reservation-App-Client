class LoginResponse {
    bool status;
    String message;
    String? accessToken;
    Data? data;

    LoginResponse({
        required this.status,
        required this.message,
        required this.accessToken,
        required this.data,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        message: json["message"],
        accessToken: json["access_token"] == null ? null : json['access_token'],
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
    int? id;
    String? email;
    String? phone;
    String? name;
    String? password;
    String? profilePicture;
    String? role;
    int? iat;

    Data({
        required this.id,
        required this.email,
        required this.phone,
        required this.name,
        required this.password,
        required this.profilePicture,
        required this.role,
        required this.iat,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        name: json["name"] == null ? null : json["name"],
        password: json["password"] == null ? null : json["password"],
        profilePicture: json["profile_picture"] == null ? null : json["profile_picture"],
        role: json["role"] == null ? null : json["role"],
        iat: json["iat"] == null ? null : json["iat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "password": password,
        "profile_picture": profilePicture,
        "role": role,
        "iat": iat,
    };
}