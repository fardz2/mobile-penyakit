import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/component/ui/penyakit_widget.dart';
import 'package:heartrate_database_u_i/component/ui/profile_widget.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';
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
          child: RefreshIndicator(
            onRefresh: () async {
              controller.searchFocusNode.unfocus();

              await controller.fetchPenyakit(
                  searchQuery: controller.searchController.text);
            },
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Bagian header dengan ClipPath
                  Obx(() {
                    return controller.landingController.isLogin.value
                        ? Stack(
                            children: [
                              ClipPath(
                                clipper: HeaderClipper(),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: customColor2, // Warna tetap sama
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ProfileWidget(),
                                          ],
                                        ),
                                        const SizedBox(height: 30),
                                        const Text(
                                          "Pilih penyakit dengan\ndata berkualitas",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                            height: 80), // Adjusted spacing
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Obx(() {
                                return controller
                                            .landingController.isLogin.value &&
                                        controller.errorMessage.value.isEmpty
                                    ? Positioned(
                                        top:
                                            200, // Adjust this value to position the search bar
                                        left: 20,
                                        right: 20,
                                        child: TextField(
                                          controller:
                                              controller.searchController,
                                          focusNode: controller.searchFocusNode,
                                          onChanged: (value) {
                                            controller.fetchPenyakit(
                                                searchQuery: value);
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Cari penyakit...',
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            prefixIcon:
                                                const Icon(Icons.search),
                                          ),
                                        ),
                                      )
                                    : const SizedBox();
                              }),
                            ],
                          )
                        : const SizedBox();
                  }),
                  // Main Content
                  Obx(() {
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
                      child: Column(
                        children: [
                          // Error or Empty State
                          if (controller.errorMessage.value.isNotEmpty)
                            _buildErrorState()
                          else if (controller.penyakitList.isEmpty)
                            _buildEmptyState()
                          else ...[
                            // List of Diseases
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 100),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.penyakitList.length +
                                    (controller.hasMorePages.value ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index < controller.penyakitList.length) {
                                    var penyakitData =
                                        controller.penyakitList[index];
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
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
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
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _Login() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 300),
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
              backgroundColor: customColor3,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Clipper untuk bentuk khusus Container
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20); // Garis ke bawah kiri
    path.quadraticBezierTo(
      size.width / 2, // Kontrol titik X
      size.height - 100, // Kontrol titik Y
      size.width, // Titik akhir X
      size.height - 20, // Titik akhir Y
    );
    path.lineTo(size.width, 0); // Garis ke atas kanan
    path.close(); // Menutup path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
