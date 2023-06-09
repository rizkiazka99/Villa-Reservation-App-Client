class UserFavoritesResponse {
    bool status;
    String message;
    List<Datum> data;

    UserFavoritesResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserFavoritesResponse.fromJson(Map<String, dynamic> json) => UserFavoritesResponse(
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
    int userId;
    int villaId;
    DateTime createdAt;
    DateTime updatedAt;
    Villa villa;

    Datum({
        required this.id,
        required this.userId,
        required this.villaId,
        required this.createdAt,
        required this.updatedAt,
        required this.villa,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["UserId"],
        villaId: json["VillaId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        villa: Villa.fromJson(json["Villa"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "UserId": userId,
        "VillaId": villaId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Villa": villa.toJson(),
    };
}

class Villa {
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
    List<VillaGalery> villaGaleries;
    Location location;

    Villa({
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
        required this.villaGaleries,
        required this.location,
    });

    factory Villa.fromJson(Map<String, dynamic> json) => Villa(
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
        villaGaleries: List<VillaGalery>.from(json["VillaGaleries"].map((x) => VillaGalery.fromJson(x))),
        location: Location.fromJson(json["Location"]),
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
        "VillaGaleries": List<dynamic>.from(villaGaleries.map((x) => x.toJson())),
        "Location": location.toJson(),
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

class VillaGalery {
    int id;
    int villaId;
    String imageName;
    DateTime createdAt;
    DateTime updatedAt;

    VillaGalery({
        required this.id,
        required this.villaId,
        required this.imageName,
        required this.createdAt,
        required this.updatedAt,
    });

    factory VillaGalery.fromJson(Map<String, dynamic> json) => VillaGalery(
        id: json["id"],
        villaId: json["VillaId"],
        imageName: json["image_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "VillaId": villaId,
        "image_name": imageName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
