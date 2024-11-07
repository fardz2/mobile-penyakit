import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/penyakit_widget.dart';

import '../controllers/penyakit_controller.dart';

class PenyakitView extends GetView<PenyakitController> {
  const PenyakitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 20),
            itemCount: controller.listPenyakit.length,
            itemBuilder: (context, index) {
              var penyakitData = controller.listPenyakit[index];
              return PenyakitCard(
                image: penyakitData["image"] as String,
                penyakit: penyakitData["penyakit"] as String,
                record: penyakitData["record"] as int,
                updated: penyakitData["updated"] as String,
              );
            },
          ),
        ),
      ),
    );
  }
}
