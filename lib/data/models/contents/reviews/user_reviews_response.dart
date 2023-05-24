class UserReviewsResponse {
    bool status;
    String message;
    List<Datum> data;

    UserReviewsResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory UserReviewsResponse.fromJson(Map<String, dynamic> json) => UserReviewsResponse(
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
    int villaId;
    int userId;
    double rating;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;
    Villa villa;

    Datum({
        required this.id,
        required this.villaId,
        required this.userId,
        required this.rating,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
        required this.villa,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        villaId: json["VillaId"],
        userId: json["UserId"],
        rating: json["rating"]?.toDouble(),
        comment: json["comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        villa: Villa.fromJson(json["Villa"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "VillaId": villaId,
        "UserId": userId,
        "rating": rating,
        "comment": comment,
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
