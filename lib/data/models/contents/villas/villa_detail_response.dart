class VillaDetailResponse {
  bool status;
  String message;
  Data data;

  VillaDetailResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VillaDetailResponse.fromJson(Map<String, dynamic> json) =>
      VillaDetailResponse(
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
  int locationId;
  String name;
  String description;
  int price;
  String mapUrl;
  String phone;
  int bedroom;
  int bathroom;
  bool swimmingPool;
  DateTime createdAt;
  DateTime updatedAt;
  Location location;
  List<VillaReview> villaReviews;
  List<Favorite> villaGaleries;
  List<Booking> bookings;
  List<Favorite> favorites;
  double? averageRating;

  Data({
    required this.id,
    required this.locationId,
    required this.name,
    required this.description,
    required this.price,
    required this.mapUrl,
    required this.phone,
    required this.bedroom,
    required this.bathroom,
    required this.swimmingPool,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
    required this.villaReviews,
    required this.villaGaleries,
    required this.bookings,
    required this.favorites,
    required this.averageRating
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        locationId: json["LocationId"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        mapUrl: json["map_url"],
        phone: json["phone"],
        bedroom: json["bedroom"],
        bathroom: json["bathroom"],
        swimmingPool: json["swimming_pool"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        location: Location.fromJson(json["Location"]),
        villaReviews: List<VillaReview>.from(
            json["VillaReviews"].map((x) => VillaReview.fromJson(x))),
        villaGaleries: List<Favorite>.from(
            json["VillaGaleries"].map((x) => Favorite.fromJson(x))),
        bookings: List<Booking>.from(
            json["Bookings"].map((x) => Booking.fromJson(x))),
        favorites: List<Favorite>.from(
            json["Favorites"].map((x) => Favorite.fromJson(x))),
        averageRating: json["averageRating"] == null ? null : json["averageRating"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "LocationId": locationId,
        "name": name,
        "description": description,
        "price": price,
        "map_url": mapUrl,
        "phone": phone,
        "bedroom": bedroom,
        "bathroom": bathroom,
        "swimming_pool": swimmingPool,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Location": location.toJson(),
        "VillaReviews": List<dynamic>.from(villaReviews.map((x) => x.toJson())),
        "VillaGaleries":
            List<dynamic>.from(villaGaleries.map((x) => x.toJson())),
        "Bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
        "Favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
        "averageRating": averageRating
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
  int? userId;
  int villaId;
  DateTime createdAt;
  DateTime updatedAt;
  String? imageName;

  Favorite({
    required this.id,
    this.userId,
    required this.villaId,
    required this.createdAt,
    required this.updatedAt,
    this.imageName,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        userId: json["UserId"],
        villaId: json["VillaId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        imageName: json["image_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "UserId": userId,
        "VillaId": villaId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "image_name": imageName,
      };
}

class Location {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  Location({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
