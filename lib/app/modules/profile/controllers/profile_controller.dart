import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final List<Map<String, dynamic>> profileData = [
    {
      'iconPath': "assets/icons/svg/profile.svg",
      'label': "Belva",
    },
    {
      'iconPath': "assets/icons/svg/envelope-fill.svg",
      'label': "mgbelvanaufal@gmail.com",
    },
    {
      'iconPath': "assets/icons/svg/building.svg",
      'label': "Rs Budiman Surga",
    },
    {
      'iconPath': "assets/icons/svg/gender-male.svg",
      'label': "Male",
    },
    {
      'iconPath': "assets/icons/svg/telephone-fill.svg",
      'label': "083874658428",
    },
    {
      'iconPath': "assets/icons/svg/file-earmark-check-fill.svg",
      'label': "Melakukan riset dalam penyakit jantung",
    },
    {
      'iconPath': "assets/icons/svg/logout.svg",
      'label': "logout",
      'iconBackgroundColor': Colors.red,
      'backgroundColor': Colors.red,
    },
  ];
}
