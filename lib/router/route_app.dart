import 'package:get/get.dart';
import 'package:reservilla/modules/binding/auth/login_screen_binding.dart';
import 'package:reservilla/modules/binding/auth/register_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/bookings_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/home_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/profile_screen_binding.dart';
import 'package:reservilla/modules/binding/miscellaneous/dashboard_screen_binding.dart';
import 'package:reservilla/modules/binding/miscellaneous/splash_screen_binding.dart';
import 'package:reservilla/modules/view/auth/login_screen.dart';
import 'package:reservilla/modules/view/auth/register_screen.dart';
import 'package:reservilla/modules/view/contents/bookings_screen.dart';
import 'package:reservilla/modules/view/contents/home_screen.dart';
import 'package:reservilla/modules/view/contents/profile_screen.dart';
import 'package:reservilla/modules/view/miscellaneous/dashboard_screen.dart';
import 'package:reservilla/modules/view/miscellaneous/splash_screen.dart';
import 'package:reservilla/router/route_variables.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: splashScreenRoute, 
      page: () => const SplashScreen(),
      binding: SplashScreenBinding()
    ),
    GetPage(
      name: loginScreenRoute, 
      page: () => const LoginScreen(),
      binding: LoginScreenBinding()
    ),
    GetPage(
      name: registerScreenRoute, 
      page: () => const RegisterScreen(),
      binding: RegisterScreenBinding()
    ),
    GetPage(
      name: dashboardScreenRoute,
      page: () => const DashboardScreen(),
      bindings: [
        DashboardScreenBinding(),
        HomeScreenBinding(),
        BookingsScreenBinding(),
        ProfileScreenBinding()
      ]
    ),
    GetPage(
      name: homeScreenRoute,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding()
    ),
    GetPage(
      name: bookingsScreenRoute,
      page: () => const BookingsScreen(),
      binding: BookingsScreenBinding()
    ),
    GetPage(
      name: profileScreenRoute,
      page: () => const ProfileScreen(),
      binding: ProfileScreenBinding()
    ),
  ];
}