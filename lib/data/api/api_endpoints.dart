import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:reservilla/helpers/common_variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods {
  Dio dio = Dio();

  handleError(error) {
    String errorDesc = '';
    DioError? dioError;

    if (error is DioError) {
      dioError = error as DioError;

      switch(dioError.type) {
        case DioErrorType.cancel:
          errorDesc = 'Request to the server was cancelled';
          break;
        case DioErrorType.connectionTimeout:
          errorDesc = 'Connection timeout with the server';
          break;
        case DioErrorType.connectionError:
          errorDesc = 'Encountered an error in connection with the server';
          break;
        case DioErrorType.sendTimeout:
          errorDesc = 'Send timeout in connection with the server';
          break;
        case DioErrorType.receiveTimeout:
          errorDesc = 'Receive timeout in connection with the server';
          break;
        case DioErrorType.badCertificate:
          errorDesc = 'Bad certificate';
          break;
        case DioErrorType.badResponse:
          errorDesc = 'Server returned a bad response';
          break;
        case DioErrorType.unknown:
          errorDesc = 'Unknown error occurred';
          break;
      } 
    } else {
      errorDesc = 'Unexpected error occurred';
    }

    print('Status Code: ${dioError!.response!.statusCode}, Message: $errorDesc');
    return dioError.response!.data;
  }

  // Auth
  Future dioLogin(url, data) async {
    try {
      final response = await dio.post(
        baseUrl + url,
        data: jsonEncode(data)
      );

      return response.data;
    } catch(err) {
      return handleError(err);
    }
  }

  Future dioSignup(url, data) async {
    try {
      final response = await dio.post(
        baseUrl + url,
        data: jsonEncode(data)
      );

      return response.data;
    } catch(err) {
      return handleError(err);
    }
  }

  // General
  Future dioGet(url, {query}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    String? accessToken = prefs.getString('access_token');

    try {
      final response = await dio.get(
        baseUrl + url,
        queryParameters: query == null ? null : Map.from(query),
        options: Options(
          headers: {
            'access_token': accessToken
          }
        )
      );

      return response.data;
    } catch(err) {
      return handleError(err);
    }
  }
  
  Future dioPost(url, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    String? accessToken = prefs.getString('access_token');

    try {
      final response = await dio.post(
        baseUrl + url,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'access_token': accessToken
          }
        )
      );
      
      print(response.data);
      return response.data;
    } catch(err) {
      return handleError(err);
    }
  }

  Future dioPut(url, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    String? accessToken = prefs.getString('access_token');

    try {
      final response = await dio.put(
        baseUrl + url,
        data: jsonEncode(data),
        options: Options(
          headers: {
            'access_token': accessToken
          }
        )
      );

      return response.data;
    } catch(err) {
      return handleError(err);
    }
  }

  Future dioDelete(url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    String? accessToken = prefs.getString('access_token');

    try {
      final response = await dio.delete(
        baseUrl + url,
        options: Options(
          headers: {
            'access_token': accessToken
          }
        )
      );

      return response.data;
    } catch(err) {
      return handleError(err);
    }
  }

  // Profile Picture Upload
  dioUploadProfilePicture(String url, FormData formData, dynamic onSendProgress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    String? accessToken = prefs.getString('access_token');

    try {
      final response = await dio.put(
        baseUrlImg + url,
        data: formData,
        onSendProgress: onSendProgress,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'access_token': accessToken
          }
        )
      );

      return response.data;
    } catch(err) {
      return handleError(err);
    }
  }
}

class Upload extends Methods {
  Future uploadProfilePicture(String id, FormData formData, Function onSendProgress) async {
    return await dioUploadProfilePicture('users/update/$id', formData, onSendProgress);
  }
}

class Users extends Methods {
  Future login(data) async {
    return await dioLogin('users/login', data);
  }

  Future signup(data) async {
    return await dioSignup('users/register', data);
  }

  Future getUserById(id) async {
    return await dioGet('users/$id');
  }

  Future verifyPassword(data) async {
    return await dioPost('users/verifyPassword', data);
  }

  Future editProfile(id, data) async {
    return await dioPut('users/update/$id', data);
  }
}

class Villas extends Methods {
  Future getVillas() async {
    return await dioGet('villas');
  }

  Future getVillaDetail(villaId) async {
    return await dioGet('villas/$villaId');
  }

  Future searchVilla(query) async {
    return await dioGet('villas/search/$query');
  }
}

class Locations extends Methods {
  Future getLocations() async {
    return await dioGet('locations');
  }

  Future getLocationDetail(id) async {
    return await dioGet('locations/$id');
  }
}

class Bookings extends Methods {
  Future book(data) async {
    return await dioPost('bookings/book', data);
  }

  Future getBookingsByUser(UserId) async {
    return await dioGet('bookings/users/$UserId');
  }

  Future getBookingDetail(id) async {
    return await dioGet('bookings/$id');
  }

  Future paymentCheck(id) async {
    return await dioGet('bookings/check/$id');
  }
}

class Reviews extends Methods {
  Future addReview(data) async {
    return await dioPost('villaReviews/add', data);
  }

  Future getUserReviews() async {
    return await dioGet('villaReviews/users');
  }

  Future getVillaReviews(id) async {
    return await dioGet('villaReviews/villa/$id');
  }

  Future getVillaReviewsAsc(id) async {
    return await dioGet('villaReviews/villa/$id/asc');
  }

  Future getVillaReviewsDesc(id) async {
    return await dioGet('villaReviews/villa/$id/desc');
  }
}

class Favorites extends Methods {
  Future getFavorites() async {
    return await dioGet('favorites/users');
  }

  Future addToFavorite(data) async {
    return await dioPost('favorites/add', data);
  }

  Future removeFromFavorite(id) async {
    return await dioDelete('favorites/delete/$id');
  }
}