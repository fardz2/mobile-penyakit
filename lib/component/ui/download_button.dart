import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/utils/file_downloader.dart'; // Import FileDownloader
import 'package:heartrate_database_u_i/component/ui/confirm_dialog.dart'; // Import your confirmation dialog

class DownloadButton extends StatelessWidget {
  final String fileName;
  final String fileUrl;
  final String buttonName;
  final Color customColor;
  final VoidCallback onPressed; // Custom onPressed function

  const DownloadButton({
    Key? key,
    required this.fileName,
    required this.fileUrl,
    required this.buttonName,
    required this.customColor,
    required this.onPressed, // Initialize the custom onPressed function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Show confirmation dialog before executing the custom onPressed function
        Get.dialog(
          ConfirmationDialog(
            title: "Konfirmasi Unduh",
            content: "Apakah Anda yakin ingin mengunduh file $fileName?",
            onConfirm: () {
              onPressed(); // Call the custom onPressed function
            },
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: customColor,
        backgroundColor: Colors.white, // Background color
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(buttonName.toUpperCase()), // Button text in uppercase
          const SizedBox(width: 8), // Space between icon and text
          const Icon(Icons.file_download), // Download icon
        ],
      ),
    );
  }
}
