import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/detail_penyakit/controllers/detail_penyakit_controller.dart';
import 'package:heartrate_database_u_i/component/ui/button_back.dart';
import 'package:heartrate_database_u_i/component/ui/confirm_dialog.dart';
import 'package:heartrate_database_u_i/utils/file_downloader.dart';

class DownloadHeaderWidget extends StatelessWidget {
  final DetailPenyakitController detailPenyakitController =
      Get.find<DetailPenyakitController>();

  DownloadHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const ButtonBack(),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 30,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () async {
                  final exportUrl = detailPenyakitController.exportUrl.value;
                  if (exportUrl.isNotEmpty) {
                    // Show confirmation dialog before downloading
                    Get.dialog(
                      ConfirmationDialog(
                        title: "Konfirmasi Unduh",
                        content: "Apakah Anda yakin ingin mengunduh file ini?",
                        onConfirm: () async {
                          // Proceed with the download
                          await FileDownloader.downloadFile(exportUrl,
                              useBearer: true);
                        },
                      ),
                    );
                  } else {
                    Get.snackbar(
                      "Info",
                      "URL untuk unduh tidak tersedia.",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.amber,
                      colorText: Colors.black,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Transparent background
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(40, 40),
                  elevation: 0,
                ),
                child: SvgPicture.asset(
                  "assets/icons/svg/download.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                "assets/images/doctor_streamline.png",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
