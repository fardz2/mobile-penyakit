import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/ui/button_back.dart';
import 'package:heartrate_database_u_i/component/ui/profile-button.dart';
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
              const ButtonBack(),
              const SizedBox(height: 20),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "assets/images/doctor_streamline.png", // Gambar default
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final user = controller.user.value;
                  return ListView(
                    children: [
                      ProfileButton(
                        iconPath: "assets/icons/svg/profile.svg",
                        label: user.name.isNotEmpty ? user.name : "No Name",
                        iconBackgroundColor: const Color(0xff554F9B),
                        backgroundColor: customColor3,
                      ),
                      const SizedBox(height: 15),
                      ProfileButton(
                        iconPath: "assets/icons/svg/envelope-fill.svg",
                        label: user.email.isNotEmpty ? user.email : "No Email",
                        iconBackgroundColor: const Color(0xff554F9B),
                        backgroundColor: customColor3,
                      ),
                      const SizedBox(height: 15),
                      ProfileButton(
                        iconPath: "assets/icons/svg/building.svg",
                        label: user.institution.isNotEmpty
                            ? user.institution
                            : "No Institution",
                        iconBackgroundColor: const Color(0xff554F9B),
                        backgroundColor: customColor3,
                      ),
                      const SizedBox(height: 15),
                      ProfileButton(
                        iconPath: "assets/icons/svg/gender-male.svg",
                        label:
                            user.gender.isNotEmpty ? user.gender : "No Gender",
                        iconBackgroundColor: const Color(0xff554F9B),
                        backgroundColor: customColor3,
                      ),
                      const SizedBox(height: 15),
                      ProfileButton(
                        iconPath: "assets/icons/svg/telephone-fill.svg",
                        label: user.phone.isNotEmpty ? user.phone : "No Phone",
                        iconBackgroundColor: const Color(0xff554F9B),
                        backgroundColor: customColor3,
                      ),
                      const SizedBox(height: 15),
                      const ProfileButton(
                        iconPath:
                            "assets/icons/svg/file-earmark-check-fill.svg",
                        label:
                            "Melakukan riset dalam penyakit jantung", // Teks hardcoded
                        iconBackgroundColor: Color(0xff554F9B),
                        backgroundColor: customColor3,
                      ),
                      const SizedBox(height: 15),
                      // Logout Button
                      GestureDetector(
                        onTap: controller.logout,
                        child: const ProfileButton(
                          iconPath: "assets/icons/svg/logout.svg",
                          label: "Logout",
                          iconBackgroundColor: Colors.red,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
