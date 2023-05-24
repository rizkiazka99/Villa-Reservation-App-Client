class VillasResponse {
  bool status;
  String message;
  List<Datum> data;

  VillasResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VillasResponse.fromJson(Map<String, dynamic> json) => VillasResponse(
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
  List<VillaGallery> villaGalleries;
  dynamic averageRating;
  List<dynamic> favorites;

  Datum({
    required this.id,
    required this.locationId,
    required this.name,
    required this.price,
    required this.location,
    required this.villaGalleries,
    required this.averageRating,
    required this.favorites,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        locationId: json["LocationId"],
        name: json["name"],
        price: json["price"],
        location: Location.fromJson(json["Location"]),
        villaGalleries: List<VillaGallery>.from(
            json["VillaGalleries"].map((x) => VillaGallery.fromJson(x))),
        averageRating: json["averageRating"]?.toDouble(),
        favorites: List<dynamic>.from(json["Favorites"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "LocationId": locationId,
        "name": name,
        "price": price,
        "Location": location.toJson(),
        "VillaGalleries":
            List<dynamic>.from(villaGalleries.map((x) => x.toJson())),
        "averageRating": averageRating,
        "Favorites": List<dynamic>.from(favorites.map((x) => x)),
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
