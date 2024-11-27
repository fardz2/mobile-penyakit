import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/component/ui/download_header_widget.dart';
import 'package:heartrate_database_u_i/component/ui/list_penyakit.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';
import '../controllers/detail_penyakit_controller.dart';

class DetailPenyakitView extends GetView<DetailPenyakitController> {
  const DetailPenyakitView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // Listener untuk infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isFetching.value &&
          controller.hasMorePages.value) {
        controller.fetchRecord(controller.penyakitId, loadMore: true);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          // Menangani loading
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Pastikan detail penyakit tidak null
          var penyakit = controller.penyakitDetail.value;
          if (penyakit == null) {
            return const Center(
              child: Text("Detail penyakit tidak tersedia."),
            );
          }

          // Tampilan utama jika detail penyakit tersedia
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchDetailPenyakit(controller.penyakitId);
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                // Header untuk detail penyakit
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DownloadHeaderWidget(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                penyakit.name,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                softWrap: true,
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
                                "${penyakit.diseaseRecordsCount} Records",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          penyakit.deskripsi,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                // Daftar penyakit berdasarkan tipe schema
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < controller.recordList.value.length) {
                        var penyakitItem = controller.recordList.value[index];

                        // Variabel untuk menyimpan data final
                        String name = "Tidak tersedia";
                        String jenis = "Tidak tersedia";
                        String tanggal = "Tidak tersedia";
                        String waktu = "Tidak tersedia";
                        bool waktuDecimalFound = false;

                        // Iterasi melalui schema untuk mencari data
                        for (var schema in controller.schema.value!) {
                          final fieldValue =
                              penyakitItem.getField(schema.name, schema);

                          // Abaikan tipe file
                          if (schema.type == "file") {
                            continue;
                          }

                          // Isi variabel jika kosong
                          if (schema.type == "string" &&
                              name == "Tidak tersedia") {
                            name = fieldValue?.toString() ?? "Tidak tersedia";
                          } else if (schema.type == "string" &&
                              jenis == "Tidak tersedia") {
                            jenis = fieldValue?.toString() ?? "Tidak tersedia";
                          } else if (schema.type == "datetime" &&
                              tanggal == "Tidak tersedia") {
                            tanggal =
                                _formatField(fieldValue, type: "datetime");
                          } else if (schema.type == "decimal" &&
                              !waktuDecimalFound) {
                            waktu = _formatField(fieldValue, type: "decimal");
                            waktuDecimalFound =
                                true; // Tandai bahwa decimal ditemukan
                          } else if (!waktuDecimalFound &&
                              schema.type == "string") {
                            waktu = fieldValue?.toString() ?? "Tidak tersedia";
                          }

                          // Jika semua data sudah terisi, hentikan iterasi
                          if (name != "Tidak tersedia" &&
                              jenis != "Tidak tersedia" &&
                              tanggal != "Tidak tersedia" &&
                              waktu != "Tidak tersedia") {
                            break;
                          }
                        }

                        // Menampilkan data dengan ListPenyakit
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.DETAIL_RECORD, arguments: {
                                "penyakit_id": controller.penyakitId,
                                "record_id": penyakitItem.id,
                              });
                            },
                            child: ListPenyakit(
                              name: name,
                              jenis: jenis,
                              tanggal: tanggal,
                              waktu: waktu,
                            ),
                          ),
                        );
                      } else {
                        // Indikator loading saat memuat lebih banyak data
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                    childCount: controller.recordList.value.length +
                        (controller.hasMorePages.value ? 1 : 0),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Fungsi untuk memformat nilai berdasarkan tipe data
  String _formatField(dynamic value, {required String type}) {
    if (value == null) return "Tidak tersedia";
    switch (type) {
      case "datetime":
        final date = DateTime.tryParse(value.toString());
        return date != null
            ? "${date.day}/${date.month}/${date.year}"
            : "Tidak valid";
      case "decimal":
        return double.tryParse(value.toString())?.toStringAsFixed(2) ??
            "Tidak valid";
      default:
        return value.toString();
    }
  }
}
