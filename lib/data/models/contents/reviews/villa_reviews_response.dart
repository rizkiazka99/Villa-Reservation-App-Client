class VillaReviewsResponse {
    bool status;
    String message;
    Data data;

    VillaReviewsResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory VillaReviewsResponse.fromJson(Map<String, dynamic> json) => VillaReviewsResponse(
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
    List<Review> reviews;
    double averageRating;

    Data({
        required this.reviews,
        required this.averageRating,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        averageRating: json["averageRating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "averageRating": averageRating,
    };
}

class Review {
    int id;
    int villaId;
    int userId;
    int rating;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    User user;

    Review({
        required this.id,
        required this.villaId,
        required this.userId,
        required this.rating,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        villaId: json["VillaId"],
        userId: json["UserId"],
        rating: json["rating"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["User"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "VillaId": villaId,
        "UserId": userId,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "User": user.toJson(),
    };
}

class User {
    int id;
    String email;
    String phone;
    String name;
    String password;
    dynamic profilePicture;
    String role;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        required this.id,
        required this.email,
        required this.phone,
        required this.name,
        required this.password,
        this.profilePicture,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        password: json["password"],
        profilePicture: json["profile_picture"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "password": password,
        "profile_picture": profilePicture,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
