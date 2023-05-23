import 'package:reservilla/data/models/auth/user_data_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  Future saveUserData(UserData user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('id', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('phone', '0${user.phone}');
    await prefs.setString('name', user.name);
  }

  Future<UserData> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); 

    int? id = prefs.getInt('id');
    String? email = prefs.getString('email');
    String? phone = prefs.getString('phone');
    String? name = prefs.getString('name');
    String? accessToken = prefs.getString('access_token');

    UserData user = UserData(
      id: id!, 
      email: email!, 
      phone: phone!, 
      name: name!, 
      accessToken: accessToken!
    );
    
    return user;
  }
}