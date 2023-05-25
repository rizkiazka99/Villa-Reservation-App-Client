class LocationDetailResponse {
    bool status;
    String message;
    List<Datum> data;

    LocationDetailResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory LocationDetailResponse.fromJson(Map<String, dynamic> json) => LocationDetailResponse(
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
    String name;
    int price;
    String location;
    double? averageRating;
    List<VillaGallery> villaGalleries;

    Datum({
        required this.id,
        required this.name,
        required this.price,
        required this.location,
        required this.averageRating,
        required this.villaGalleries,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        location: json["location"],
        averageRating: json["averageRating"] == null ? null : json["averageRating"]?.toDouble(),
        villaGalleries: List<VillaGallery>.from(json["VillaGalleries"].map((x) => VillaGallery.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "location": location,
        "averageRating": averageRating,
        "VillaGalleries": List<dynamic>.from(villaGalleries.map((x) => x.toJson())),
    };
}

class VillaGallery {
    int id;
    int villaId;
    String imageName;
    DateTime createdAt;
    DateTime updatedAt;

    VillaGallery({
        required this.id,
        required this.villaId,
        required this.imageName,
        required this.createdAt,
        required this.updatedAt,
    });

    factory VillaGallery.fromJson(Map<String, dynamic> json) => VillaGallery(
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