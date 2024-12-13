import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/login/controllers/login_controller.dart';
import 'package:heartrate_database_u_i/component/ui/custom_text_field.dart';
import 'package:heartrate_database_u_i/component/ui/gender_group.dart';
import 'package:heartrate_database_u_i/helpers/login_validation.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class Signup extends StatelessWidget {
  final LoginController controller = Get.find();
  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Form(
      key: controller.formSignup,
      child: Column(
        children: [
          CustomTextField(
            controller: controller.emailSignUpController,
            labelText: "Email",
            prefixIcon: const Icon(
              Icons.email,
              color: customColor3,
            ),
            validator: LoginValidation.email,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: controller.nameSignUpController,
            labelText: "Name",
            prefixIcon: const Icon(
              Icons.person,
              color: customColor3,
            ),
            validator: LoginValidation.name,
          ),
          const SizedBox(height: 15),
          GenderGroup(),
          const SizedBox(height: 15),
          CustomTextField(
            controller: controller.phoneSignUpController,
            labelText: "Phone Number",
            prefixIcon: Container(
              padding: const EdgeInsets.all(13),
              child: SvgPicture.asset(
                "assets/icons/svg/telephone-fill.svg",
                width: 10,
                height: 10,
                color: customColor3,
              ),
            ),
            isNumeric: true,
            validator: LoginValidation.phoneNumber,
          ),
          const SizedBox(height: 15),
          Obx(() {
            return CustomTextField(
              controller: controller.passwordSignUpController,
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
              obscureText: controller.passwordSignUp.value,
              onPressed: controller.togglePasswordSignUp,
              validator: LoginValidation.password,
            );
          }),
          const SizedBox(height: 15),
          Obx(() {
            return CustomTextField(
              controller: controller.confirmPasswordSignUpController,
              labelText: "Konfirmasi Password",
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
              obscureText: controller.confirmPassword.value,
              onPressed: controller.toggleConfirmPasswordSignUp,
              validator: (value) {
                return LoginValidation.confirmPassword(
                  value,
                  controller.passwordSignUpController.text,
                );
              },
            );
          }),
          const SizedBox(height: 15),
          CustomTextField(
            controller: controller.institusiSignUpController,
            labelText: "Institusi",
            prefixIcon: Container(
              padding: const EdgeInsets.all(13),
              child: SvgPicture.asset(
                "assets/icons/svg/building.svg",
                width: 10,
                height: 10,
                color: customColor3,
              ),
            ),
            validator: LoginValidation.instiusi,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: controller.tujuanPermohonanSignUpController,
            labelText: "Tujuan Permohonan",
            prefixIcon: Container(
              padding: const EdgeInsets.all(13),
              child: SvgPicture.asset(
                "assets/icons/svg/file-earmark-check-fill.svg",
                width: 10,
                height: 10,
                color: customColor3,
              ),
            ),
            validator: LoginValidation.tujuanPermohonan,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: width,
            child: Obx(() {
              return ElevatedButton(
                  onPressed: () {
                    if (controller.isLoading.value) {
                      return; // Prevent multiple taps
                    }
                    controller.signUp(); // Call the login method
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
