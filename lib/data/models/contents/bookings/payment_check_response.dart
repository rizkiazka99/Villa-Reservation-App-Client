class PaymentCheckResponse {
    bool status;
    String message;
    dynamic data;

    PaymentCheckResponse({
        required this.status,
        required this.message,
        this.data,
    });

    factory PaymentCheckResponse.fromJson(Map<String, dynamic> json) => PaymentCheckResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data,
    };
}
