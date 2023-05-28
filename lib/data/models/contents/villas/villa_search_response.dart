class VillaSearchResponse {
    bool status;
    String message;
    List<Datum> data;

    VillaSearchResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory VillaSearchResponse.fromJson(Map<String, dynamic> json) => VillaSearchResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    int locationId;
    String name;
    int price;
    Location location;
    List<Favorite> villaGalleries;
    double? averageRating;
    List<Favorite> favorites;

    Datum({
        required this.id,
        required this.locationId,
        required this.name,
        required this.price,
        required this.location,
        required this.villaGalleries,
        this.averageRating,
        required this.favorites,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        locationId: json["LocationId"],
        name: json["name"],
        price: json["price"],
        location: Location.fromJson(json["Location"]),
        villaGalleries: List<Favorite>.from(json["VillaGalleries"].map((x) => Favorite.fromJson(x))),
        averageRating: json["averageRating"]?.toDouble(),
        favorites: List<Favorite>.from(json["Favorites"].map((x) => Favorite.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "LocationId": locationId,
        "name": name,
        "price": price,
        "Location": location.toJson(),
        "VillaGalleries": List<dynamic>.from(villaGalleries.map((x) => x.toJson())),
        "averageRating": averageRating,
        "Favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
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
