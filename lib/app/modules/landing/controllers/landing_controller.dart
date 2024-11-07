import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/home/controllers/home_controller.dart';
import 'package:heartrate_database_u_i/app/modules/home/views/home_view.dart';
import 'package:heartrate_database_u_i/app/modules/penyakit/controllers/penyakit_controller.dart';
import 'package:heartrate_database_u_i/app/modules/penyakit/views/penyakit_view.dart';

class LandingController extends GetxController {
  //TODO: Implement LandingController

  final index = 0.obs;

  final List<Widget> pages = [const HomeView(), const PenyakitView()];
  void onChangePage(int val) {
    index.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(HomeController());
    Get.put(PenyakitController());
  }
}
