import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/routes/app_pages.dart';
import 'package:heartrate_database_u_i/component/ui/grid_item.dart';
import 'package:heartrate_database_u_i/component/ui/profile_widget.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';
import 'package:heartrate_database_u_i/utils/time_helper.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => controller.fetchPenyakit(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: HeaderClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: customColor3,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(() {
                                return controller
                                        .landingController.isLogin.value
                                    ? ProfileWidget(color: Colors.white)
                                    : const SizedBox();
                              }),
                            ],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "HealthCare\nDatabase Penyakit",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(controller.about.length, (index) {
                        final item = controller.about[index];
                        return GridItem(
                          icon: item["icon"],
                          title: item["label"],
                          content: item["content"],
                          titleContent: item["title"],
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Gradient Container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          customColor,
                          customColor.withOpacity(0.5),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jelajahi semua Database Penyakit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Jelajahi, Analisis, Kemudian Berbagi Data Berkualitas kepada Pasien.",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        // Container for the image
                        Container(
                          width: 120, // Fixed width for the image
                          height: 120, // Fixed height for the image
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image: AssetImage(
                                  "assets/images/Medical prescription and treatment plan (1).png"),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(
                                10), // Optional: rounded corners
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return controller.landingController.isLogin.value &&
                          controller.errorMessage.value.isEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Penyakit Populer",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            // List of Popular Diseases
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Obx(() {
                                return controller.isLoading.value
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            controller.penyakitList.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30),
                                                bottomLeft: Radius.circular(30),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  30)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: dotenv.env[
                                                            'STORAGE_URL']! +
                                                        controller
                                                            .penyakitList[index]
                                                            .coverPage,
                                                    fit: BoxFit.cover,
                                                    width: 100,
                                                    height: 130,
                                                    placeholder:
                                                        (context, url) =>
                                                            const Center(
                                                      child:
                                                          CircularProgressIndicator(), // Placeholder saat gambar sedang dimuat
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons
                                                            .error), // Menampilkan ikon error jika gagal memuat gambar
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width:
                                                        10), // Add some spacing
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        controller
                                                            .penyakitList[index]
                                                            .name,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.55,
                                                        child: Text(
                                                          "${controller.penyakitList[index].diseaseRecordsCount} Record • Updated ${TimeHelper.formatTime(controller.penyakitList[index].updatedAt)}",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 30,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Get.toNamed(
                                                              Routes
                                                                  .DETAIL_PENYAKIT,
                                                              arguments: controller
                                                                  .penyakitList[
                                                                      index]
                                                                  .id,
                                                            );
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                WidgetStateProperty
                                                                    .all(
                                                                        customColor),
                                                            shape:
                                                                WidgetStateProperty
                                                                    .all(
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                          ),
                                                          child: const Text(
                                                              "Read More",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 5,
                                        ),
                                      );
                              }),
                            ),
                          ],
                        )
                      : const SizedBox();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Clipper for Header
class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20); // Line to bottom left
    path.quadraticBezierTo(
      size.width / 2, // Control point X
      size.height - 100, // Control point Y
      size.width, // End point X
      size.height - 20, // End point Y
    );
    path.lineTo(size.width, 0); // Line to top right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
