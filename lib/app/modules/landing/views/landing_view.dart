import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:heartrate_database_u_i/component/navbar-item.dart';

import '../controllers/landing_controller.dart';

class LandingView extends GetView<LandingController> {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Obx(() {
        return Stack(
          children: [
            IndexedStack(
              index: controller.index.value,
              children: controller.pages,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                data:
                    Theme.of(context).copyWith(canvasColor: Colors.transparent),
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => controller.onChangePage(0),
                            child: NavbarItem(
                              active: "assets/icons/home.png",
                              inactive: "assets/icons/home-inactive.png",
                              status: controller.index.value == 0,
                              label: "Home",
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () => controller.onChangePage(1),
                            child: NavbarItem(
                              active: "assets/icons/myocardial-icon-active.png",
                              inactive:
                                  "assets/icons/myocardial-icon-inactive.png",
                              status: controller.index.value == 1,
                              label: "Penyakit",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
