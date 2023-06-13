import 'package:dio/dio.dart';
import 'package:reservilla/data/api/api_endpoints.dart';
import 'package:reservilla/data/models/auth/login_response.dart';
import 'package:reservilla/data/models/auth/register_response.dart';
import 'package:reservilla/data/models/auth/verify_password_response.dart';
import 'package:reservilla/data/models/contents/bookings/book_response.dart';
import 'package:reservilla/data/models/contents/bookings/booking_detail_response.dart';
import 'package:reservilla/data/models/contents/bookings/bookings_response.dart';
import 'package:reservilla/data/models/contents/bookings/payment_check_response.dart';
import 'package:reservilla/data/models/contents/favorites/add_to_favorite_response.dart';
import 'package:reservilla/data/models/contents/favorites/remove_from_favorite_response.dart';
import 'package:reservilla/data/models/contents/favorites/user_favorites_response.dart';
import 'package:reservilla/data/models/contents/locations/location_detail_response.dart';
import 'package:reservilla/data/models/contents/locations/locations_response.dart';
import 'package:reservilla/data/models/contents/profile/edit_profile_response.dart';
import 'package:reservilla/data/models/contents/reviews/add_review_response.dart';
import 'package:reservilla/data/models/contents/reviews/villa_reviews_response.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
import 'package:reservilla/data/models/contents/villas/villa_search_response.dart';
import 'package:reservilla/data/models/contents/villas/villas_response.dart';
import 'package:reservilla/data/models/miscellaneous/user_response.dart';

import '../models/contents/reviews/user_reviews_response.dart';

class Repository {
  Users usersApi = Users();
  Upload uploadApi = Upload();
  Villas villasApi = Villas();
  Locations locationsApi = Locations();
  Bookings bookingsApi = Bookings();
  Reviews reviewsApi = Reviews();
  Favorites favoritesApi = Favorites();
  
  // Users/Auth
  Future<LoginResponse> login(data) async {
    final response = await usersApi.login(data);
    return LoginResponse.fromJson(response);
  }

  Future<RegisterResponse> signup(data) async {
    final response = await usersApi.signup(data);
    return RegisterResponse.fromJson(response);
  }

  Future<VerifyPasswordResponse> verifyPassword(data) async {
    final response = await usersApi.verifyPassword(data);
    return VerifyPasswordResponse.fromJson(response);
  }

  Future<EditProfileResponse> editProfile(id, data) async {
    final response = await usersApi.editProfile(id, data);
    return EditProfileResponse.fromJson(response);
  }

  Future<EditProfileResponse> uploadProfilePicture(String id, FormData formData, Function onSendProgress) async {
    final response = await uploadApi.uploadProfilePicture(id, formData, onSendProgress);
    return EditProfileResponse.fromJson(response);
  }

  Future<UserResponse> getUserById(id) async {
    final response = await usersApi.getUserById(id);
    print(response);
    return UserResponse.fromJson(response);
  }

  // Locations
  Future<LocationsResponse> getLocations() async {
    final response = await locationsApi.getLocations();
    return LocationsResponse.fromJson(response);
  }

  Future<LocationDetailResponse> getLocationDetail(id) async {
    final response = await locationsApi.getLocationDetail(id);
    return LocationDetailResponse.fromJson(response);
  }

  // Villas
  Future<VillasResponse> getVillas() async {
    final response = await villasApi.getVillas();
    return VillasResponse.fromJson(response);
  }

  Future<VillaDetailResponse> getVillaDetail(villaId) async {
    final response = await villasApi.getVillaDetail(villaId);
    return VillaDetailResponse.fromJson(response);
  }

  Future<VillaSearchResponse> searchVilla(query) async {
    final response = await villasApi.searchVilla(query);
    return VillaSearchResponse.fromJson(response);
  }

  // Bookings
  Future<BookResponse> book(data) async {
    final response = await bookingsApi.book(data);
    print(response);
    return BookResponse.fromJson(response);
  }

  Future<BookingsResponse> getBookingsByUser(UserId) async {
    final response = await bookingsApi.getBookingsByUser(UserId);
    return BookingsResponse.fromJson(response);
  }

  Future<BookingDetailResponse> getBookingDetail(id) async {
    final response = await bookingsApi.getBookingDetail(id);
    return BookingDetailResponse.fromJson(response);
  }

  Future<PaymentCheckResponse> paymentCheck(id) async {
    final response = await bookingsApi.paymentCheck(id);
    return PaymentCheckResponse.fromJson(response);
  }

  // Reviews
  Future<AddReviewResponse> addReview(data) async {
    final response = await reviewsApi.addReview(data);
    return AddReviewResponse.fromJson(response);
  }

  Future<UserReviewsResponse> getUserReviews() async {
    final response = await reviewsApi.getUserReviews();
    return UserReviewsResponse.fromJson(response);
  }

  Future<VillaReviewsResponse> getVillaReviews(id) async {
    final response = await reviewsApi.getVillaReviews(id);
    return VillaReviewsResponse.fromJson(response);
  }

  Future<VillaReviewsResponse> getVillaReviewsAsc(id) async {
    final response = await reviewsApi.getVillaReviewsAsc(id);
    return VillaReviewsResponse.fromJson(response);
  }

  Future<VillaReviewsResponse> getVillaReviewsDesc(id) async {
    final response = await reviewsApi.getVillaReviewsDesc(id);
    return VillaReviewsResponse.fromJson(response);
  }

  // Favorites
  Future<UserFavoritesResponse> getUserFavorites() async {
    final response = await favoritesApi.getFavorites();
    return UserFavoritesResponse.fromJson(response);
  }

  Future<AddToFavoriteResponse> addToFavorite(data) async {
    final response = await favoritesApi.addToFavorite(data);
    return AddToFavoriteResponse.fromJson(response);
  }

  Future<RemoveFromFavoriteResponse> removeFromFavorite(id) async {
    final response = await favoritesApi.removeFromFavorite(id);
    return RemoveFromFavoriteResponse.fromJson(response);
  }
}