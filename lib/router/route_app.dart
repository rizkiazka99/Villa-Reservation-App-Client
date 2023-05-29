import 'package:get/get.dart';
import 'package:reservilla/modules/binding/auth/login_screen_binding.dart';
import 'package:reservilla/modules/binding/auth/register_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/bookings/booking_detail_binding.dart';
import 'package:reservilla/modules/binding/contents/bookings/bookings_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/favorites/user_favorites_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/home_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/locations/location_detail_binding.dart';
import 'package:reservilla/modules/binding/contents/profile/edit_profile_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/profile/profile_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/reviews/add_review_binding.dart';
import 'package:reservilla/modules/binding/contents/reviews/user_reviews_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/villas/all_villas_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/villas/book_success_screen.binding.dart';
import 'package:reservilla/modules/binding/contents/villas/book_villa_screen_binding.dart';
import 'package:reservilla/modules/binding/contents/villas/villa_detail_binding.dart';
import 'package:reservilla/modules/binding/miscellaneous/dashboard_screen_binding.dart';
import 'package:reservilla/modules/binding/miscellaneous/splash_screen_binding.dart';
import 'package:reservilla/modules/view/auth/login_screen.dart';
import 'package:reservilla/modules/view/auth/register_screen.dart';
import 'package:reservilla/modules/view/contents/bookings/booking_detail_screen.dart';
import 'package:reservilla/modules/view/contents/bookings/bookings_screen.dart';
import 'package:reservilla/modules/view/contents/favorites/user_favorites_screen.dart';
import 'package:reservilla/modules/view/contents/home_screen.dart';
import 'package:reservilla/modules/view/contents/location/location_detail_screen.dart';
import 'package:reservilla/modules/view/contents/profile/edit_profile_screen.dart';
import 'package:reservilla/modules/view/contents/profile/profile_screen.dart';
import 'package:reservilla/modules/view/contents/reviews/add_review_screen.dart';
import 'package:reservilla/modules/view/contents/reviews/user_reviews_screen.dart';
import 'package:reservilla/modules/view/contents/villas/all_villas_screen.dart';
import 'package:reservilla/modules/view/contents/villas/book_success_screen.dart';
import 'package:reservilla/modules/view/contents/villas/book_villa_screen.dart';
import 'package:reservilla/modules/view/contents/villas/villa_detail_screen.dart';
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
    GetPage(
      name: bookingDetailScreenRoute, 
      page: () => const BookingDetailScreen(),
      binding: BookingDetailBinding()
    ),
    GetPage(
      name: addReviewScreenRoute,
      page: () => const AddReviewScreen(),
      binding: AddReviewBinding()
    ),
    GetPage(
      name: userReviewsScreenRoute,
      page: () => const UserReviewsScreen(),
      binding: UserReviewsScreenBinding()
    ),
    GetPage(
      name: editProfileScreenRoute,
      page: () => const EditProfileScreen(),
      binding: EditProfileScreenBinding()
    ),
    GetPage(
      name: villaDetailScreenRoute,
      page: () => const VillaDetailScreen(),
      binding: VillaDetailBinding()
    ),
    GetPage(
      name: locationDetailScreenRoute,
      page: () => const LocationDetailScreen(),
      binding: LocationDetailScreenBinding()
    ),
    GetPage(
      name: allVillasScreenRoute,
      page: () => const AllVillasScreen(),
      binding: AllVillasScreenBinding()
    ),
    GetPage(
      name: bookVillaScreenRoute,
      page: () => const BookVillaScreen(),
      binding: BookVillaScreenBinding()
    ),
    GetPage(
      name: bookSuccessScreenRoute,
      page: () => const BookSuccessScreen(),
      binding: BookSuccessScreenBinding()
    ),
    GetPage(
      name: userFavoritesScreenRoute,
      page: () => const UserFavoritesScreen(),
      binding: UserFavoritesScreenBinding()
    )
  ];
}