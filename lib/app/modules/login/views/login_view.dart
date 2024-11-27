import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/layouts/auth/login.dart';
import 'package:heartrate_database_u_i/component/layouts/auth/signup.dart';
import 'package:heartrate_database_u_i/component/ui/button_back.dart';
import 'package:heartrate_database_u_i/component/ui/login_signup_toogle.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          bool isLoggedIn = controller
              .isLoginSelected.value; // Check if login or signup is selected
          return SingleChildScrollView(
            child: Container(
              // Set background image based on login status, aligned to the top
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    isLoggedIn
                        ? "assets/images/loginframe.png" // Background for login
                        : "assets/images/background.png", // Background for signup
                  ),
                  alignment: Alignment.topCenter, // Align image at the top
                  fit: isLoggedIn ? null : BoxFit.cover, // Fill the screen
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: ButtonBack(),
                  ),
                  // Responsive SizedBox based on screen height
                  SizedBox(
                    height: isLoggedIn
                        ? MediaQuery.of(context).size.height *
                            0.38 // 30% of screen height
                        : 0, // No extra space if not logged in
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoginSignUpToggle(),
                        const SizedBox(height: 10),
                        const Text(
                          "Know Your HeartRate by Entering Your HeartRate Into The Application",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        // Display the appropriate widget based on login state
                        isLoggedIn ? Login() : Signup(),
                      ],
                    ),
                  ),
                  // Responsive spacing at the bottom
                  SizedBox(
                      height: MediaQuery.of(context).size.height *
                          0.05), // 5% of screen height
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
