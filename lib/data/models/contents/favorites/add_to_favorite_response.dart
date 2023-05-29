class AddToFavoriteResponse {
    bool status;
    String message;
    Data data;

    AddToFavoriteResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddToFavoriteResponse.fromJson(Map<String, dynamic> json) => AddToFavoriteResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    int userId;
    int villaId;
    DateTime updatedAt;
    DateTime createdAt;

    Data({
        required this.id,
        required this.userId,
        required this.villaId,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["UserId"],
        villaId: json["VillaId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "UserId": userId,
        "VillaId": villaId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}