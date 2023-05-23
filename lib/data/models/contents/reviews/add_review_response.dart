class AddReviewResponse {
    bool status;
    String message;
    Data? data;

    AddReviewResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory AddReviewResponse.fromJson(Map<String, dynamic> json) => AddReviewResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    int id;
    int villaId;
    int userId;
    double rating;
    String comment;
    DateTime updatedAt;
    DateTime createdAt;

    Data({
        required this.id,
        required this.villaId,
        required this.userId,
        required this.rating,
        required this.comment,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        villaId: json["VillaId"],
        userId: json["UserId"],
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "VillaId": villaId,
        "UserId": userId,
        "rating": rating,
        "comment": comment,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}
