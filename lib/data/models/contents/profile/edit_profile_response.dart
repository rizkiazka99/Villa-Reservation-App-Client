class EditProfileResponse {
    bool status;
    String message;

    EditProfileResponse({
        required this.status,
        required this.message,
    });

    factory EditProfileResponse.fromJson(Map<String, dynamic> json) => EditProfileResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
