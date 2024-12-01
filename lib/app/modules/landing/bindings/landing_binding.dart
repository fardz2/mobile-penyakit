import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/home/controllers/home_controller.dart';
import 'package:heartrate_database_u_i/app/modules/penyakit/controllers/penyakit_controller.dart';
import 'package:heartrate_database_u_i/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/landing_controller.dart';

class LandingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingController>(
      () => LandingController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<PenyakitController>(
      () => PenyakitController(),
    );
    Get.put<ProfileController>(ProfileController(), permanent: true);
  }
}
