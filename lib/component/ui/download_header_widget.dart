import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:heartrate_database_u_i/app/modules/detail_penyakit/controllers/detail_penyakit_controller.dart';
import 'package:heartrate_database_u_i/component/ui/button_back.dart';
import 'package:heartrate_database_u_i/utils/storage_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart'; // Import for random UUID

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
                    await _downloadFile(exportUrl);
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
                  backgroundColor: Colors.transparent, // Transparan
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

  Map<String, String> _setHeaders() {
    final token = StorageService.getToken(
        "auth_token"); // Replace with actual Bearer token
    return {
      'X-API-KEY': 'randomapikey123', // Your API Key
      'Authorization': 'Bearer $token', // Bearer token for authorization
      'ngrok-skip-browser-warning': 'true'
    };
  }

  /// Fungsi untuk mengunduh file dengan menggunakan FlutterDownloader
  Future<void> _downloadFile(String url) async {
    try {
      // Memeriksa dan meminta izin penyimpanan
      var permissionStatus = await Permission.storage.request();
      if (!permissionStatus.isGranted) {
        throw Exception("Izin penyimpanan ditolak.");
      }

      // Mendapatkan direktori untuk penyimpanan file
      final externalDir = await getExternalStorageDirectory();
      final directoryPath = externalDir?.path;

      if (directoryPath == null) {
        throw Exception("Gagal mendapatkan direktori penyimpanan.");
      }

      // Mengambil nama file acak dengan ekstensi CSV
      var uuid = Uuid();
      final randomFileName =
          '${uuid.v4()}.csv'; // Generate random file name with .csv extension

      final savePath = '$directoryPath/$randomFileName';

      // Mengunduh file dengan FlutterDownloader dan headers
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        headers: _setHeaders(), // Menambahkan headers ke request
        savedDir: directoryPath, // Direktori tempat file disimpan
        fileName: randomFileName, // Nama file yang diunduh
        showNotification: true, // Menampilkan notifikasi selama proses download
        openFileFromNotification: true, // Membuka file setelah selesai
      );

      print("Download task started with ID: $taskId");

      Get.snackbar(
        "Berhasil",
        "File sedang diunduh: $randomFileName",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengunduh file: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error downloading file: $e");
    }
  }
}
