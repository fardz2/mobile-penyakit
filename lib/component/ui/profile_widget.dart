import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/profile/controllers/profile_controller.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';

class ProfileWidget extends StatelessWidget {
  final Color color;
  final ProfileController profileController = Get.find<ProfileController>();
  ProfileWidget({super.key, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PROFILE);
      },
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              "assets/images/doctor_streamline.png",
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning",
                style: TextStyle(color: color),
              ),
              Obx(() {
                final userName = profileController.user.value.name;
                return Text(
                  userName.isNotEmpty
                      ? userName
                      : 'Loading', // Fallback jika nama kosong
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
