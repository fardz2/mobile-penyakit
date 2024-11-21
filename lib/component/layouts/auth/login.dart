import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:heartrate_database_u_i/app/modules/login/controllers/login_controller.dart';
import 'package:heartrate_database_u_i/component/ui/custom_text_field.dart';
import 'package:heartrate_database_u_i/helpers/login_validation.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class Login extends StatelessWidget {
  final LoginController controller = Get.find();
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formLogin,
      child: Column(
        children: [
          CustomTextField(
            controller: controller.emailLoginController,
            labelText: "Email",
            prefixIcon: const Icon(
              Icons.email,
              color: Color(0xff53516C),
            ),
            validator: LoginValidation.email,
          ),
          const SizedBox(height: 15),
          Obx(() {
            return CustomTextField(
              controller: controller.passwordLoginController,
              labelText: "Password",
              prefixIcon: Image.asset(
                "assets/icons/password.png",
                width: 20,
              ),
              isPassword: true,
              obscureText: controller.passwordLogin.value,
              onPressed: controller.togglePasswordLogin,
              validator: LoginValidation.password,
            );
          }),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.login,
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
              child: const Text("Login", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
