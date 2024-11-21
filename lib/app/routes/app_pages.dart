import 'package:get/get.dart';

import '../modules/detail_penyakit/bindings/detail_penyakit_binding.dart';
import '../modules/detail_penyakit/views/detail_penyakit_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/opening/bindings/opening_binding.dart';
import '../modules/opening/views/opening_view.dart';
import '../modules/penyakit/views/penyakit_view.dart';

import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.OPENING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
    ),
    GetPage(
      name: _Paths.OPENING,
      page: () => const OpeningView(),
      binding: OpeningBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
    ),
    GetPage(
      name: _Paths.PENYAKIT,
      page: () => PenyakitView(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: _Paths.DETAIL_PENYAKIT,
      page: () => const DetailPenyakitView(),
      binding: DetailPenyakitBinding(),
    ),
  ];
}
