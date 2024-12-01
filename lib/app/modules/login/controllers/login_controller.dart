import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/home/controllers/home_controller.dart';
import 'package:heartrate_database_u_i/app/modules/landing/controllers/landing_controller.dart';
import 'package:heartrate_database_u_i/app/modules/penyakit/controllers/penyakit_controller.dart';
import 'package:heartrate_database_u_i/app/modules/profile/controllers/profile_controller.dart';

import 'package:heartrate_database_u_i/utils/api/auth/AuthService.dart';

class LoginController extends GetxController {
  final formLogin = GlobalKey<FormState>();
  final formSignup = GlobalKey<FormState>();
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  final emailSignUpController = TextEditingController();
  final nameSignUpController = TextEditingController();
  final phoneSignUpController = TextEditingController();
  final passwordSignUpController = TextEditingController();
  final confirmPasswordSignUpController = TextEditingController();
  final tujuanPermohonanSignUpController = TextEditingController();
  final institusiSignUpController = TextEditingController();

  final institutionSignUpController = TextEditingController();

  var isLoginSelected = true.obs;
  final passwordLogin = true.obs;
  final passwordSignUp = true.obs;
  final confirmPassword = true.obs;
  final isLoading = false.obs;
  final gender = ''.obs;
  final LandingController landingController = Get.find();
  final PenyakitController penyakitController = Get.find();
  final ProfileController profileController = Get.find();
  final HomeController homeController = Get.find();

  void login() async {
    if (formLogin.currentState!.validate()) {
      isLoading.value = true;
      try {
        await AuthService().login(
          emailLoginController.text,
          passwordLoginController.text,
        );
        landingController.setLogin();
        penyakitController.errorMessage.value = '';
        penyakitController.fetchPenyakit();
        profileController.loadProfile();
        homeController.fetchPenyakit();

        Get.back();
        Get.snackbar('Success Login', 'You have successfully Logged in',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
      } catch (e) {
        print('Terjadi kesalahan saat login: $e');

        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } finally {
        isLoading.value = false;
      }
    }
  }

  void signUp() async {
    if (formSignup.currentState!.validate()) {
      isLoginSelected.value = false;
      isLoading.value = true;
      try {
        await AuthService().signUp(
          email: emailSignUpController.text,
          name: nameSignUpController.text,
          phoneNumber: phoneSignUpController.text,
          password: passwordSignUpController.text,
          passwordConfirmation: confirmPasswordSignUpController.text,
          institution: institutionSignUpController.text,
          gender: gender.value,
          institusi: institusiSignUpController.text,
          tujuanPermohonan: tujuanPermohonanSignUpController.text,
        );
        Get.snackbar('Success Regiter', 'You have successfully registered',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        isLoginSelected.value = true;
      } catch (e) {
        print('Terjadi kesalahan saat registrasi: $e');

        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      } finally {
        isLoading.value = false;
      }
    }
  }

  void toggle(bool isLogin) {
    isLoginSelected.value = isLogin;
  }

  void togglePasswordLogin() {
    passwordLogin.value = !passwordLogin.value;
  }

  void togglePasswordSignUp() {
    passwordSignUp.value = !passwordSignUp.value;
  }

  void toggleConfirmPasswordSignUp() {
    confirmPassword.value = !confirmPassword.value;
  }

  void changeGender(String value) {
    gender.value = value;
  }
}
