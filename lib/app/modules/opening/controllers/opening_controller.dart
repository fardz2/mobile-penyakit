import 'package:get/get.dart';
import 'package:heartrate_database_u_i/utils/storage_service.dart';
import '../../../routes/app_pages.dart';

class OpeningController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    // Menentukan navigasi berdasarkan kondisi token
    if (StorageService.getToken('auth_token') != null) {
      // Jika token auth ada, navigasi ke halaman Landing
      Get.offAllNamed(Routes.LANDING);
    } else if (StorageService.getToken("isFirstTime") != null) {
      // Jika token isFirstTime ada, navigasi ke halaman Login
      Get.offAllNamed(Routes.LOGIN);
    } else {
      // Jika tidak ada token sama sekali, biarkan OpeningView tetap muncul
    }
  }
}
