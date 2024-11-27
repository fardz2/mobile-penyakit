import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/ui/grid_item.dart';

import 'package:heartrate_database_u_i/component/ui/profile_widget.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Bagian header
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                decoration: const BoxDecoration(
                  color: customColor3, // Warna tetap sama
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            return controller.landingController.isLogin.value
                                ? ProfileWidget(
                                    color: Colors.white,
                                  )
                                : const SizedBox();
                          }),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "HealthCare\nDatabase Penyakit",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),
            // Grid Content
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: controller.about.length,
              itemBuilder: (context, index) {
                final item = controller.about[index];
                return GridItem(
                  icon: Icons.info_outline,
                  title: item["label"],
                  content: item["content"],
                  titleContent: item["title"],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Clipper untuk bentuk khusus Container
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20); // Garis ke bawah kiri
    path.quadraticBezierTo(
      size.width / 2, // Kontrol titik X
      size.height - 100, // Kontrol titik Y
      size.width, // Titik akhir X
      size.height - 20, // Titik akhir Y
    );
    path.lineTo(size.width, 0); // Garis ke atas kanan
    path.close(); // Menutup path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
