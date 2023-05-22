class BookingsResponse {
    bool status;
    String message;
    List<Datum> data;

    BookingsResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory BookingsResponse.fromJson(Map<String, dynamic> json) => BookingsResponse(
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
    String id;
    int userId;
    int villaId;
    int totalPrice;
    String bookingStartDate;
    String bookingEndDate;
    Payment payment;
    String status;
    String paymentVia;
    User user;
    Villa villa;
    DateTime createdAt;
    DateTime updatedAt;

    Datum({
        required this.id,
        required this.userId,
        required this.villaId,
        required this.totalPrice,
        required this.bookingStartDate,
        required this.bookingEndDate,
        required this.payment,
        required this.status,
        required this.paymentVia,
        required this.user,
        required this.villa,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["UserId"],
        villaId: json["VillaId"],
        totalPrice: json["total_price"],
        bookingStartDate: json["booking_start_date"],
        bookingEndDate: json["booking_end_date"],
        payment: Payment.fromJson(json["payment"]),
        status: json["status"],
        paymentVia: json["payment_via"],
        user: User.fromJson(json["User"]),
        villa: Villa.fromJson(json["Villa"]),
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
        "payment": payment.toJson(),
        "status": status,
        "payment_via": paymentVia,
        "User": user.toJson(),
        "Villa": villa.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class Payment {
    DateTime transactionTime;
    String grossAmount;
    String currency;
    String orderId;
    String paymentType;
    String? signatureKey;
    String statusCode;
    String transactionId;
    String transactionStatus;
    String fraudStatus;
    DateTime? expiryTime;
    DateTime? settlementTime;
    String statusMessage;
    String merchantId;
    String? permataVaNumber;
    List<VaNumber>? vaNumbers;
    List<dynamic>? paymentAmounts;

    Payment({
        required this.transactionTime,
        required this.grossAmount,
        required this.currency,
        required this.orderId,
        required this.paymentType,
        required this.signatureKey,
        required this.statusCode,
        required this.transactionId,
        required this.transactionStatus,
        required this.fraudStatus,
        required this.expiryTime,
        required this.settlementTime,
        required this.statusMessage,
        required this.merchantId,
        this.permataVaNumber,
        this.vaNumbers,
        this.paymentAmounts,
    });

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        transactionTime: DateTime.parse(json["transaction_time"]),
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        orderId: json["order_id"],
        paymentType: json["payment_type"],
        signatureKey: json["signature_key"] == null ? null : json["signature_key"],
        statusCode: json["status_code"],
        transactionId: json["transaction_id"],
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        expiryTime: json['expiry_time'] == null ? null : DateTime.parse(json["expiry_time"]),
        settlementTime: json["settlement_time"] == null ? null : DateTime.parse(json["settlement_time"]),
        statusMessage: json["status_message"],
        merchantId: json["merchant_id"],
        permataVaNumber: json["permata_va_number"],
        vaNumbers: json["va_numbers"] == null ? [] : List<VaNumber>.from(json["va_numbers"]!.map((x) => VaNumber.fromJson(x))),
        paymentAmounts: json["payment_amounts"] == null ? [] : List<dynamic>.from(json["payment_amounts"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "transaction_time": transactionTime.toIso8601String(),
        "gross_amount": grossAmount,
        "currency": currency,
        "order_id": orderId,
        "payment_type": paymentType,
        "signature_key": signatureKey,
        "status_code": statusCode,
        "transaction_id": transactionId,
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "expiry_time": expiryTime!.toIso8601String(),
        "settlement_time": settlementTime!.toIso8601String(),
        "status_message": statusMessage,
        "merchant_id": merchantId,
        "permata_va_number": permataVaNumber,
        "va_numbers": vaNumbers == null ? [] : List<dynamic>.from(vaNumbers!.map((x) => x.toJson())),
        "payment_amounts": paymentAmounts == null ? [] : List<dynamic>.from(paymentAmounts!.map((x) => x)),
    };
}

class VaNumber {
    String bank;
    String vaNumber;

    VaNumber({
        required this.bank,
        required this.vaNumber,
    });

    factory VaNumber.fromJson(Map<String, dynamic> json) => VaNumber(
        bank: json["bank"],
        vaNumber: json["va_number"],
    );

    Map<String, dynamic> toJson() => {
        "bank": bank,
        "va_number": vaNumber,
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
        required this.villaGaleries
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
