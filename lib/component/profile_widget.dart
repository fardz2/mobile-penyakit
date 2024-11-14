import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PROFILE);
      },
      child: const Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(
              "assets/images/doctor_streamline.png",
            ),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning"),
              Text("Belva",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
