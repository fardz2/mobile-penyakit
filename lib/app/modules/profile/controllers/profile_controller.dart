import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/utils/api/auth/AuthService.dart';
import 'package:heartrate_database_u_i/utils/storage_service.dart';
import 'package:heartrate_database_u_i/app/models/user/User.dart';

class ProfileController extends GetxController {
  final user =
      User(id: 0, name: '', email: '', institution: '', gender: '', phone: '')
          .obs;
  final isLoading = false.obs;

  // Fungsi untuk mengambil data profil pengguna
  @override
  void onInit() {
    super.onInit();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    isLoading.value = true;
    try {
      final fetchedUser = await AuthService().getProfile();

      user.value = fetchedUser;
    } catch (e) {
      print("Error fetching profile: $e");
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
    Get.offAllNamed(Routes.LOGIN);
  }
}
