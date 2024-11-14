import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/component/penyakit_widget.dart';
import 'package:heartrate_database_u_i/component/profile_widget.dart';

import '../controllers/penyakit_controller.dart';

class PenyakitView extends GetView<PenyakitController> {
  const PenyakitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const ProfileWidget(),
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
                const SizedBox(height: 20),
                const Text(
                  "Pilih Penyakit",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 20),
                  itemCount: controller.listPenyakit.length,
                  itemBuilder: (context, index) {
                    var penyakitData = controller.listPenyakit[index];
                    bool isEven = index % 2 == 0;
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20), // Ganti 10 dengan jarak yang diinginkan
                      child: PenyakitCard(
                        image: penyakitData["image"] as String,
                        penyakit: penyakitData["penyakit"] as String,
                        record: penyakitData["record"] as int,
                        updated: penyakitData["updated"] as String,
                        listPenyakit: penyakitData["list_penyakit"]
                            as List<Map<String, String>>,
                        alignment: isEven
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
