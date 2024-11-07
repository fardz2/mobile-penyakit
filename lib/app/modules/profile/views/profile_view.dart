import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/profile-button.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 30,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .transparent, // Mengatur latar belakang menjadi transparan
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(40, 40),
                    elevation: 0, // Menghilangkan elevation default
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/svg/chevron right.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "assets/images/doctor_streamline.png",
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.profileData.length,
                  itemBuilder: (context, index) {
                    final data = controller.profileData[index];
                    return Column(
                      children: [
                        ProfileButton(
                          iconPath: data['iconPath'],
                          label: data['label'],
                          iconBackgroundColor:
                              data['iconBackgroundColor'] ?? Color(0xff554F9B),
                          backgroundColor:
                              data['backgroundColor'] ?? customColor3,
                        ),
                        const SizedBox(height: 15),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
