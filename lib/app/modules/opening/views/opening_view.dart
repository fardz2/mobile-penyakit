import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

import '../../../routes/app_pages.dart';
import '../controllers/opening_controller.dart';

class OpeningView extends GetView<OpeningController> {
  const OpeningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Center(
            child: Image.asset("assets/images/doctor_streamline.png"),
          ),
          const SizedBox(height: 30),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: customColor)),
                Text(
                    "system for uploading and downloading heart rate data from two databases, one for arrhythmia and one for myocardial infarction. The downloaded files can be in graph form and CSV if selected."),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed(Routes.LOGIN);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text("Continue",
                    style: TextStyle(
                        color: customColor, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: 15,
                      decoration: const BoxDecoration(
                        color: customColor,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: customColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "assets/icons/arrow.png",
                          width: 35,
                          height: 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    )));
  }
}
