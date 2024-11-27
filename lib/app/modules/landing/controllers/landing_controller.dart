import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:heartrate_database_u_i/app/modules/home/views/home_view.dart';

import 'package:heartrate_database_u_i/app/modules/penyakit/views/penyakit_view.dart';
import 'package:heartrate_database_u_i/utils/storage_service.dart';

class LandingController extends GetxController {
  final index = 0.obs;
  final isLogin = false.obs;
  final List<Widget> pages = [const HomeView(), const PenyakitView()];
  void onChangePage(int val) {
    index.value = val;
  }

  Future<void> setLogin() async {
    await Future.delayed(Duration.zero); // Tunggu hingga build selesai
    isLogin.value = StorageService.getToken('auth_token') != null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setLogin();
    });
  }
}
