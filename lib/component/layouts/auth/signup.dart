import 'package:flutter/material.dart';
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
    return Form(
      key: controller.formSignup,
      child: Column(
        children: [
          CustomTextField(
            controller: controller.emailSignUpController,
            labelText: "Email",
            prefixIcon: const Icon(
              Icons.email,
              color: Color(0xff53516C),
            ),
            validator: LoginValidation.email,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: controller.nameSignUpController,
            labelText: "Name",
            prefixIcon: const Icon(
              Icons.person,
              color: Color(0xff53516C),
            ),
            validator: LoginValidation.name,
          ),
          const SizedBox(height: 15),
          GenderGroup(),
          const SizedBox(height: 15),
          CustomTextField(
            controller: controller.phoneSignUpController,
            labelText: "Phone Number",
            prefixIcon: const Icon(
              Icons.phone,
              color: Color(0xff53516C),
            ),
            isNumeric: true,
            validator: LoginValidation.phoneNumber,
          ),
          const SizedBox(height: 15),
          Obx(() {
            return CustomTextField(
              controller: controller.passwordSignUpController,
              labelText: "Password",
              prefixIcon: Image.asset(
                "assets/icons/password.png",
                width: 20,
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
              prefixIcon: Image.asset(
                "assets/icons/password.png",
                width: 20,
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
            prefixIcon: Image.asset(
              "assets/icons/password.png",
              width: 20,
            ),
            validator: LoginValidation.instiusi,
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: controller.tujuanPermohonanSignUpController,
            labelText: "Tujuan Permohonan",
            prefixIcon: Image.asset(
              "assets/icons/password.png",
              width: 20,
            ),
            validator: LoginValidation.tujuanPermohonan,
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.signUp,
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
              child:
                  const Text("Sign Up", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
