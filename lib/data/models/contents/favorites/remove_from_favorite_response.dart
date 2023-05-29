class RemoveFromFavoriteResponse {
    bool status;
    String message;

    RemoveFromFavoriteResponse({
        required this.status,
        required this.message,
    });

    factory RemoveFromFavoriteResponse.fromJson(Map<String, dynamic> json) => RemoveFromFavoriteResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}