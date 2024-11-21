import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/login/controllers/login_controller.dart';

class LoginSignUpToggle extends StatelessWidget {
  final LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF5A4ABF), // Warna ungu latar
        borderRadius: BorderRadius.circular(30), // Membuat lingkaran
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tombol Login
          GestureDetector(
            onTap: () => controller.toggle(true),
            child: Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: controller.isLoginSelected.value
                      ? const Color(
                          0xFF2C2836) // Warna hitam untuk tombol aktif
                      : Colors.transparent, // Tidak ada warna jika tidak aktif
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: controller.isLoginSelected.value
                        ? Colors.white // Warna teks aktif
                        : const Color(0xFF2C2836), // Warna teks tidak aktif
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Tombol Sign Up
          GestureDetector(
            onTap: () => controller.toggle(false),
            child: Obx(
              () => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: !controller.isLoginSelected.value
                      ? const Color(
                          0xFF2C2836) // Warna hitam untuk tombol aktif
                      : Colors.transparent, // Tidak ada warna jika tidak aktif
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: !controller.isLoginSelected.value
                        ? Colors.white // Warna teks aktif
                        : const Color(0xFF2C2836), // Warna teks tidak aktif
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
