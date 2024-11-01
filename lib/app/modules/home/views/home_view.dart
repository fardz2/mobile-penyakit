import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/about_widget.dart';
import 'package:heartrate_database_u_i/component/bullet-card.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(children: [
              // Bagian header
              Container(
                decoration: const BoxDecoration(
                  color: customColor2,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  "assets/images/doctor_streamline.png",
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Good Morning"),
                                  Text("Belva",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.zero,
                                shadowColor: Colors.transparent,
                              ),
                              onPressed: () {},
                              child: Center(
                                child: Image.asset('assets/icons/notif.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Take Care of\nYour Heart Health",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Obx(() {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.about.value = "arrythmia";
                              },
                              child: AboutWidget(
                                active:
                                    "assets/icons/arrythmia-icon-active.png",
                                inactive:
                                    "assets/icons/arrythmia-icon-inactive.png",
                                status: controller.about.value == "arrythmia",
                                label: "About Arrythmia",
                              ),
                            ),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                controller.about.value = "myocardial";
                              },
                              child: AboutWidget(
                                active:
                                    "assets/icons/myocardial-icon-active.png",
                                inactive:
                                    "assets/icons/myocardial-icon-inactive.png",
                                status: controller.about.value == "myocardial",
                                label: "About Myocardial",
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() {
                  return controller.about.value == "arrythmia"
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller
                              .itemsArrythmia.length, // Ganti dengan items
                          itemBuilder: (context, index) {
                            return BulletListCard(
                              icon: controller.itemsArrythmia[index]["icon"],
                              title: controller.itemsArrythmia[index]["title"],
                              items: List<String>.from(
                                  controller.itemsArrythmia[index]["items"]),
                            );
                          },
                        )
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller
                              .itemsMyocardial.length, // Ganti dengan items
                          itemBuilder: (context, index) {
                            return BulletListCard(
                              icon: controller.itemsMyocardial[index]["icon"],
                              title: controller.itemsMyocardial[index]["title"],
                              items: List<String>.from(
                                  controller.itemsMyocardial[index]["items"]),
                            );
                          },
                        );
                }),
              ),
            ])),
      ),
    );
  }
}
