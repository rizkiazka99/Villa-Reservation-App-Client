import 'package:get/get.dart';
import 'package:reservilla/modules/binding/auth/login_screen_binding.dart';
import 'package:reservilla/modules/view/auth/login_screen.dart';
import 'package:reservilla/router/route_variables.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: loginScreenRoute, 
      page: () => const LoginScreen(),
      binding: LoginScreenBinding()
    )
  ];
}