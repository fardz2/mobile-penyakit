import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/landing/controllers/landing_controller.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/utils/api/auth/AuthService.dart';
import 'package:heartrate_database_u_i/utils/storage_service.dart';
import 'package:heartrate_database_u_i/app/models/user/User.dart';

class ProfileController extends GetxController {
  final user = User(
    id: 0,
    name: '',
    email: '',
    institution: '',
    gender: '',
    phone: '',
  ).obs;
  final isLoading = false.obs;
  final LandingController landingController = Get.find();

  // Fungsi untuk mengambil data profil pengguna
  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    try {
      final fetchedUser = await AuthService().getProfile();

      user.value = fetchedUser;
    } catch (e) {
      print("Error fetching profile: $e");
      if (e.toString() == "Unauthenticated") {
        StorageService.clearToken("auth_token");
        landingController.setLogin();
      }
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    StorageService.clearToken("auth_token");

    Get.snackbar(
      'Logout',
      'Anda telah berhasil logout',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAllNamed(Routes.LANDING);
  }
}
