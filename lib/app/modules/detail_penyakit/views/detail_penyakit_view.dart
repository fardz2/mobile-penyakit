import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/button_back.dart';
import 'package:heartrate_database_u_i/component/download_header_widget.dart';
import 'package:heartrate_database_u_i/component/list_penyakit.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

import '../controllers/detail_penyakit_controller.dart';

class DetailPenyakitView extends GetView<DetailPenyakitController> {
  const DetailPenyakitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DownloadHeaderWidget(),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.arguments['penyakit'],
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        softWrap:
                            true, // Memastikan teks membungkus ke baris berikutnya jika panjang
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        color: customColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${controller.arguments['record']} Record",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Aritmia adalah gangguan pada irama detak jantung. Dalam kondisi normal, jantung berdetak dengan ritme yang teratur. Namun, pada aritmia, ritme ini terganggu.",
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari...",
                          suffixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.5,
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          customColor.withOpacity(0.5),
                        ),
                        padding:
                            WidgetStateProperty.all(const EdgeInsets.all(15)),
                        shadowColor:
                            WidgetStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list),
                    ),
                  ],
                ),
                // const ListPenyakit()
                const SizedBox(
                  height: 20,
                ),
                ListView.separated(
                    itemCount: controller.arguments["list_penyakit"].length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var penyakitItem =
                          controller.arguments["list_penyakit"][index];
                      return ListPenyakit(
                        name: penyakitItem["name"],
                        jenis: penyakitItem["jenis"],
                        tanggal: penyakitItem["tanggal"],
                        waktu: penyakitItem["waktu"],
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
