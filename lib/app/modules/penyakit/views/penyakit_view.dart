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

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !controller.isLoadMore.value &&
          controller.hasMorePages.value) {
        controller.fetchMorePenyakit(); // Load more ketika sampai di bawah
      }
    });

    return GestureDetector(
      onTap: () {
        // Hapus fokus dari semua input saat pengguna mengetuk di luar
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Obx(() {
            if (controller.landingController.isLogin.value == false) {
              return _Login();
            }

            return RefreshIndicator(
              onRefresh: () async {
                controller.searchFocusNode
                    .unfocus(); // Tutup keyboard saat refresh
                await controller.fetchPenyakit(
                    searchQuery: controller.searchController.text);
              },
              child: CustomScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Profile Section
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

                  // Title Section
                  const SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Pilih penyakit \nyang anda inginkan",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                  // Search Section
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    sliver: SliverToBoxAdapter(
                      child: TextField(
                        controller: controller.searchController,
                        focusNode: controller.searchFocusNode,
                        onChanged: (value) {
                          controller.fetchPenyakit(searchQuery: value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari Penyakit...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),

                  // Error or Empty State
                  if (controller.errorMessage.value.isNotEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _buildErrorState(),
                    )
                  else if (controller.penyakitList.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _buildEmptyState(),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
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
                                  controller.searchFocusNode.unfocus();
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
      ),
    );
  }

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
          _buildRetryButton(),
        ],
      ),
    );
  }

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
          _buildRetryButton(),
        ],
      ),
    );
  }

  Widget _buildRetryButton() {
    return ElevatedButton(
      onPressed: () {
        controller.fetchPenyakit(); // Retry fetching data
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: const Text("Muat Ulang"),
    );
  }

  Widget _Login() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Belum login, silahkan login terlebih dahulu.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.LOGIN);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
