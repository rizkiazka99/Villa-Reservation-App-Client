class LocationsResponse {
  bool status;
  String message;
  List<Datum> data;

  LocationsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LocationsResponse.fromJson(Map<String, dynamic> json) =>
      LocationsResponse(
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
  DateTime createdAt;
  DateTime updatedAt;
  List<Villa> villas;

  Datum({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.villas,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        villas: List<Villa>.from(json["Villas"].map((x) => Villa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Villas": List<dynamic>.from(villas.map((x) => x.toJson())),
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
      };
}
