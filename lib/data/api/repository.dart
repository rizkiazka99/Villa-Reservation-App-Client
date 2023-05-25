import 'package:dio/dio.dart';
import 'package:reservilla/data/api/api_endpoints.dart';
import 'package:reservilla/data/models/auth/login_response.dart';
import 'package:reservilla/data/models/auth/register_response.dart';
import 'package:reservilla/data/models/contents/bookings/booking_detail_response.dart';
import 'package:reservilla/data/models/contents/bookings/bookings_response.dart';
import 'package:reservilla/data/models/contents/bookings/payment_check_response.dart';
import 'package:reservilla/data/models/contents/locations/location_detail_response.dart';
import 'package:reservilla/data/models/contents/locations/locations_response.dart';
import 'package:reservilla/data/models/contents/profile/edit_profile_response.dart';
import 'package:reservilla/data/models/contents/reviews/add_review_response.dart';
import 'package:reservilla/data/models/contents/villas/villa_detail_response.dart';
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
  
  Future<LoginResponse> login(data) async {
    final response = await usersApi.login(data);
    return LoginResponse.fromJson(response);
  }

  Future<RegisterResponse> signup(data) async {
    final response = await usersApi.signup(data);
    return RegisterResponse.fromJson(response);
  }

  Future uploadFile(FormData formData, Function onSendProgress) async {
    final response = await uploadApi.uploadFile(formData, onSendProgress);
    return response;
  }

  Future<LocationsResponse> getLocations() async {
    final response = await locationsApi.getLocations();
    return LocationsResponse.fromJson(response);
  }

  Future<LocationDetailResponse> getLocationDetail(id) async {
    final response = await locationsApi.getLocationDetail(id);
    return LocationDetailResponse.fromJson(response);
  }

  Future<VillasResponse> getVillas() async {
    final response = await villasApi.getVillas();
    return VillasResponse.fromJson(response);
  }

  Future<VillaDetailResponse> getVillaDetail(villaId) async {
    final response = await villasApi.getVillaDetail(villaId);
    return VillaDetailResponse.fromJson(response);
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

  Future<UserResponse> getUserById(id) async {
    final response = await usersApi.getUserById(id);
    return UserResponse.fromJson(response);
  }

  Future<AddReviewResponse> addReview(data) async {
    final response = await reviewsApi.addReview(data);
    return AddReviewResponse.fromJson(response);
  }

  Future<UserReviewsResponse> getUserReviews() async {
    final response = await reviewsApi.getUserReviews();
    return UserReviewsResponse.fromJson(response);
  }

  Future<EditProfileResponse> editProfile(id, data) async {
    final response = await usersApi.editProfile(id, data);
    return EditProfileResponse.fromJson(response);
  }
}