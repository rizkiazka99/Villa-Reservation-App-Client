import 'package:reservilla/data/api/api_endpoints.dart';
import 'package:reservilla/data/models/auth/login_response.dart';

class Repository {
  Users usersApi = Users();

  Future<LoginResponse> login(data) async {
    final response = await usersApi.login(data);
    print(response);
    return LoginResponse.fromJson(response);
  }
}