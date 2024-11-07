import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      Get.offAllNamed(Routes.LANDING);
    }
  }
}
