import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/home/controllers/home_controller.dart';
import 'package:heartrate_database_u_i/app/modules/home/views/home_view.dart';

class LandingController extends GetxController {
  //TODO: Implement LandingController

  final index = 0.obs;

  final List<Widget> pages = [
    HomeView(),
    Center(
      child: Text("List Penyakit"),
    ),
  ];
  void onChangePage(int val) {
    index.value = val;
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(HomeController());
  }
}
