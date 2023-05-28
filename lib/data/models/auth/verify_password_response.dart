class VerifyPasswordResponse {
    bool status;
    String message;

    VerifyPasswordResponse({
        required this.status,
        required this.message,
    });

    factory VerifyPasswordResponse.fromJson(Map<String, dynamic> json) => VerifyPasswordResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
