import 'dart:convert';
import 'package:dio/dio.dart';

class Methods {
  Dio dio = Dio();
  String baseUrl = 'http://10.0.2.2:3000/api/'; // Local, Emulator

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
}

class Users extends Methods {
  Future login(data) async {
    return await dioLogin('users/login', data);
  }

  Future signup(data) async {
    return await dioSignup('users/register', data);
  }
}