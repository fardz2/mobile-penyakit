import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:heartrate_database_u_i/utils/storage_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path; // Import path package

class FileDownloader {
  // Function to set headers for the download request with optional Bearer token
  static Map<String, String> _setHeaders({bool useBearer = false}) {
    final apiKey = dotenv.env['API_KEY'] as String;
    final headers = {'X-API-KEY': apiKey, 'ngrok-skip-browser-warning': 'true'};

    if (useBearer) {
      final token = StorageService.getToken(
          "auth_token"); // Replace with actual Bearer token
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  /// Function to download a file using FlutterDownloader
  static Future<void> downloadFile(String url, {bool useBearer = false}) async {
    try {
      // Check and request storage permission
      var permissionStatus = await Permission.storage.request();
      if (!permissionStatus.isGranted) {
        throw Exception("Storage permission denied.");
      }

      // Get the directory for file storage
      final externalDir = await getExternalStorageDirectory();
      final directoryPath = externalDir?.path;

      if (directoryPath == null) {
        throw Exception("Failed to get storage directory.");
      }

      // Extract the file extension from the URL
      String fileExtension = path.extension(url); // Get the file extension
      if (fileExtension.isEmpty) {
        fileExtension = '.csv'; // Default to .csv if no extension found
      }

      // Generate a random file name with the extracted extension
      var uuid = Uuid();
      final randomFileName = '${uuid.v4()}$fileExtension';

      final savePath = '$directoryPath/$randomFileName';

      // Download the file with FlutterDownloader and headers
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        headers:
            _setHeaders(useBearer: useBearer), // Adding headers to the request
        savedDir: directoryPath, // Directory to save the file
        fileName: randomFileName, // Name of the downloaded file
        showNotification: true, // Show notification during download
        openFileFromNotification: true, // Open file after download
      );

      print("Download task started with ID: $taskId");

      Get.snackbar(
        "Success",
        "File is being downloaded: $randomFileName",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to download file: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print("Error downloading file: $e");
    }
  }
}
