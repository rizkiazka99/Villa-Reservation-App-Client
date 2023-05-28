class BookResponse {
    bool status;
    String message;
    Data? data;

    BookResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"])
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
    };
}

class Data {
    String id;
    int userId;
    int villaId;
    int totalPrice;
    String bookingStartDate;
    String bookingEndDate;
    String payment;
    String status;
    String paymentVia;
    DateTime updatedAt;
    DateTime createdAt;

    Data({
        required this.id,
        required this.userId,
        required this.villaId,
        required this.totalPrice,
        required this.bookingStartDate,
        required this.bookingEndDate,
        required this.payment,
        required this.status,
        required this.paymentVia,
        required this.updatedAt,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["UserId"],
        villaId: json["VillaId"],
        totalPrice: json["total_price"],
        bookingStartDate: json["booking_start_date"],
        bookingEndDate: json["booking_end_date"],
        payment: json["payment"],
        status: json["status"],
        paymentVia: json["payment_via"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
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
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
    };
}