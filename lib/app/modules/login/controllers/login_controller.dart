import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
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
  final gender = ''.obs;

  void login() async {
    if (formLogin.currentState!.validate()) {
      try {
        await AuthService().login(
          emailLoginController.text,
          passwordLoginController.text,
        );
        Get.snackbar('Success Login', 'You have successfully Logged in',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        Get.offAllNamed(Routes.LANDING);
      } catch (e) {
        print('Terjadi kesalahan saat login: $e');

        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
      print(dotenv.env['API_URL']);
    }
  }

  void signUp() async {
    if (formSignup.currentState!.validate()) {
      isLoginSelected.value = false;
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
      }
      print(dotenv.env['API_URL']);
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
