class UserResponse {
    bool status;
    String message;
    Data data;

    UserResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
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
    String email;
    String phone;
    String name;
    dynamic profilePicture;
    String role;
    DateTime createdAt;
    DateTime updatedAt;
    List<Favorite> favorites;
    List<VillaReview> villaReviews;
    List<Booking> bookings;

    Data({
        required this.id,
        required this.email,
        required this.phone,
        required this.name,
        this.profilePicture,
        required this.role,
        required this.createdAt,
        required this.updatedAt,
        required this.favorites,
        required this.villaReviews,
        required this.bookings,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        phone: json["phone"],
        name: json["name"],
        profilePicture: json["profile_picture"],
        role: json["role"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        favorites: List<Favorite>.from(json["Favorites"].map((x) => Favorite.fromJson(x))),
        villaReviews: List<VillaReview>.from(json["VillaReviews"].map((x) => VillaReview.fromJson(x))),
        bookings: List<Booking>.from(json["Bookings"].map((x) => Booking.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phone": phone,
        "name": name,
        "profile_picture": profilePicture,
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
        "VillaReviews": List<dynamic>.from(villaReviews.map((x) => x.toJson())),
        "Bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
    };
}

class Booking {
    String id;
    int userId;
    int villaId;
    int totalPrice;
    String bookingStartDate;
    String bookingEndDate;
    String payment;
    String status;
    String paymentVia;
    DateTime createdAt;
    DateTime updatedAt;

    Booking({
        required this.id,
        required this.userId,
        required this.villaId,
        required this.totalPrice,
        required this.bookingStartDate,
        required this.bookingEndDate,
        required this.payment,
        required this.status,
        required this.paymentVia,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        userId: json["UserId"],
        villaId: json["VillaId"],
        totalPrice: json["total_price"],
        bookingStartDate: json["booking_start_date"],
        bookingEndDate: json["booking_end_date"],
        payment: json["payment"],
        status: json["status"],
        paymentVia: json["payment_via"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "UserId": userId,
        "VillaId": villaId,
        "total_price": totalPrice,
        "booking_start_date": bookingStartDate,
        "booking_end_date": bookingEndDate,
        "payment": payment,
        "status": status,
        "payment_via": paymentVia,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Favorite {
    int id;
    int userId;
    int villaId;
    DateTime createdAt;
    DateTime updatedAt;

    Favorite({
        required this.id,
        required this.userId,
        required this.villaId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        userId: json["UserId"],
        villaId: json["VillaId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "UserId": userId,
        "VillaId": villaId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class VillaReview {
    int id;
    int villaId;
    int userId;
    double rating;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;

    VillaReview({
        required this.id,
        required this.villaId,
        required this.userId,
        required this.rating,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
    });

    factory VillaReview.fromJson(Map<String, dynamic> json) => VillaReview(
        id: json["id"],
        villaId: json["VillaId"],
        userId: json["UserId"],
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "VillaId": villaId,
        "UserId": userId,
        "rating": rating,
        "comment": comment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}