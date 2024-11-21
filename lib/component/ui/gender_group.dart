import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/login/controllers/login_controller.dart';
import 'package:heartrate_database_u_i/component/ui/gender_button.dart';

class GenderGroup extends StatelessWidget {
  final LoginController controller = Get.find();

  GenderGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Expanded(
            child: GenderButton(
              icon: Icons.male,
              onPressed: () {
                controller.changeGender("male");
              },
              isSelected: controller.gender.value == "male", // Check selection
            ),
          );
        }),
        const SizedBox(width: 20),
        Obx(() {
          return Expanded(
            child: GenderButton(
              icon: Icons.female,
              onPressed: () {
                controller.changeGender("female");
              },
              isSelected:
                  controller.gender.value == "female", // Check selection
            ),
          );
        }),
      ],
    );
  }
}
