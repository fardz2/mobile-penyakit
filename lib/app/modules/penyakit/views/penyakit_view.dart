import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/component/ui/penyakit_widget.dart';
import 'package:heartrate_database_u_i/component/ui/profile_widget.dart';
import '../controllers/penyakit_controller.dart';

class PenyakitView extends GetView<PenyakitController> {
  const PenyakitView({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    // Menambahkan listener untuk infinite scroll
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.fetchPenyakit(loadMore: true);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          // Kondisi jika terjadi error atau data kosong
          if (controller.errorMessage.value.isNotEmpty) {
            return _buildErrorState();
          } else if (controller.penyakitList.isEmpty) {
            return _buildEmptyState();
          }

          // Tampilan utama jika data tersedia
          return RefreshIndicator(
            onRefresh: () async {
              await controller.fetchPenyakit(); // Refresh data
            },
            child: CustomScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Profile and Notification Row
                SliverPadding(
                  padding: const EdgeInsets.all(20),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileWidget(),
                      ],
                    ),
                  ),
                ),

                // Title
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      "Pilih Penyakit",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                // List of Penyakit
                SliverPadding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < controller.penyakitList.length) {
                          var penyakitData = controller.penyakitList[index];
                          return PenyakitCard(
                            image: penyakitData.coverPage,
                            penyakit: penyakitData.name,
                            record: penyakitData.diseaseRecordsCount,
                            updated: penyakitData.updatedAt,
                            onTap: () {
                              Get.toNamed(
                                Routes.DETAIL_PENYAKIT,
                                arguments: penyakitData.id,
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                      childCount: controller.penyakitList.length +
                          (controller.hasMorePages.value ? 1 : 0),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Widget untuk tampilan error
  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 80),
          const SizedBox(height: 20),
          Text(
            controller.errorMessage.value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.fetchMorePenyakit(); // Mencoba memuat ulang data
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              "Coba Lagi",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk tampilan data kosong
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Tidak ada data penyakit yang tersedia.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.fetchPenyakit(); // Mencoba memuat ulang data
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text("Muat Ulang"),
          ),
        ],
      ),
    );
  }
}
