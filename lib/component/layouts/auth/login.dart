import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:heartrate_database_u_i/app/modules/login/controllers/login_controller.dart';
import 'package:heartrate_database_u_i/component/ui/custom_text_field.dart';
import 'package:heartrate_database_u_i/utils/helpers/login_validation.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class Login extends StatelessWidget {
  final LoginController controller = Get.find();
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: controller.formLogin,
      child: Column(
        children: [
          CustomTextField(
            controller: controller.emailLoginController,
            labelText: "Email",
            prefixIcon: const Icon(
              Icons.email,
              color: customColor3,
            ),
            validator: LoginValidation.email,
          ),
          const SizedBox(height: 15),
          Obx(() {
            return CustomTextField(
              controller: controller.passwordLoginController,
              labelText: "Password",
              prefixIcon: Container(
                padding: const EdgeInsets.all(13),
                child: SvgPicture.asset(
                  "assets/icons/svg/password.svg",
                  width: 10,
                  height: 10,
                  color: customColor3,
                ),
              ),
              isPassword: true,
              obscureText: controller.passwordLogin.value,
              onPressed: controller.togglePasswordLogin,
              validator: LoginValidation.password,
            );
          }),
          const SizedBox(height: 15),
          SizedBox(
            width: width,
            child: Obx(() {
              return ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.value) {
                      return; // Prevent multiple taps
                    }
                    controller.login(); // Call the login method
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Adjust the row size to fit its children
                    children: [
                      if (controller
                          .isLoading.value) // Show loading indicator if loading
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors
                                .white, // Set the color of the loading indicator
                            strokeWidth: 2, // Adjust the stroke width if needed
                          ),
                        ),
                      const SizedBox(
                          width:
                              8), // Spacing between the loading indicator and text
                      const Text("Login",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ));
            }),
          ),
        ],
      ),
    );
  }
}
