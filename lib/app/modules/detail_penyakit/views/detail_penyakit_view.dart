import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/component/ui/download_header_widget.dart';
import 'package:heartrate_database_u_i/component/ui/list_penyakit.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';
import '../controllers/detail_penyakit_controller.dart';

class DetailPenyakitView extends GetView<DetailPenyakitController> {
  const DetailPenyakitView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // Menambahkan listener untuk infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
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

          // Pastikan penyakitDetail tidak null
          var penyakit = controller.penyakitDetail.value;
          if (penyakit == null) {
            return const Center(
              child: Text("Detail penyakit tidak tersedia."),
            );
          }

          // Tampilan utama jika penyakit tidak null
          return RefreshIndicator(
            onRefresh: () async {
              await controller
                  .fetchDetailPenyakit(controller.penyakitId); // Refresh data
            },
            child: CustomScrollView(
              controller:
                  scrollController, // ScrollController untuk infinite scroll
              slivers: [
                // SliverAppBar to fix DownloadHeaderWidget at the top
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DownloadHeaderWidget(), // Fixed at the top
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
                                "${penyakit.diseaseRecordsCount} Record",
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

                        // Search and Filter Section
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Cari...",
                                  suffixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 0.5, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  customColor.withOpacity(0.5),
                                ),
                                padding: WidgetStateProperty.all(
                                    const EdgeInsets.all(15)),
                                shadowColor:
                                    WidgetStateProperty.all(Colors.transparent),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.filter_list),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < controller.recordList.length) {
                        var penyakitItem = controller.recordList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 20, // Padding untuk setiap item
                          ),
                          child: ListPenyakit(
                            name: penyakitItem?.data?.record ?? "No Record",
                            jenis: penyakitItem?.data?.jenis ?? "Unknown",
                            tanggal: penyakitItem?.data?.tanggalTes ??
                                "Tanggal tidak tersedia",
                            waktu: penyakitItem?.data?.durasi.toString() ??
                                "Durasi tidak tersedia",
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    childCount: controller.recordList.length +
                        (controller.hasMorePages.value ? 1 : 0),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
