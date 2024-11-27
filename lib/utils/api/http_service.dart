import 'dart:convert';
import 'dart:io'; // Untuk file handling
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:heartrate_database_u_i/utils/storage_service.dart';
import 'package:uuid/uuid.dart'; // Jika Anda menggunakan StorageService

class HttpService {
  // Fungsi untuk membuat header request
  static Map<String, String> getHeaders({bool includeBearer = false}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-API-KEY': dotenv.env['API_KEY'] as String,
    };

    // Menambahkan Bearer token jika diperlukan
    if (includeBearer) {
      headers['Authorization'] =
          'Bearer ${StorageService.getToken("auth_token")}';
    }

    return headers;
  }

  // Fungsi untuk melakukan POST request
  static Future<http.Response> postRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeBearer = false,
  }) async {
    try {
      final Uri url = Uri.parse('${dotenv.env["API_URL"]}$endpoint');
      final headers = getHeaders(includeBearer: includeBearer);
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(body),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi untuk melakukan GET request
  static Future<http.Response> getRequest(String endpoint,
      {bool includeBearer = false}) async {
    try {
      final Uri url = Uri.parse('${dotenv.env["API_URL"]}$endpoint');
      final headers = getHeaders(includeBearer: includeBearer);
      final response = await http.get(
        url,
        headers: headers,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Fungsi untuk mengunduh file langsung dari URL
  static Future<File?> downloadFile(
    String fileUrl, {
    bool includeBearer = false,
    String? saveAs, // Nama file opsional
  }) async {
    try {
      // Memeriksa dan meminta izin penyimpanan
      final permission = await Permission.storage.request();
      if (!permission.isGranted) {
        throw Exception("Izin penyimpanan ditolak.");
      }

      final Uri url = Uri.parse(fileUrl);
      final headers = getHeaders(includeBearer: includeBearer);

      // Memulai unduhan file
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        // Mendapatkan direktori eksternal yang dapat diakses oleh aplikasi
        final directory = await getExternalStorageDirectory();

        // Pastikan direktori valid
        if (directory == null) {
          throw Exception("Direktori penyimpanan eksternal tidak tersedia.");
        }

        // Buat nama file random jika tidak disediakan
        final randomFileName = const Uuid().v4(); // Menggunakan UUID
        final fileName = saveAs ?? "$randomFileName.csv"; // Default ke CSV
        final filePath = '${directory.path}/$fileName';

        // Menyimpan file yang diunduh
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return file; // Mengembalikan file yang diunduh
      } else {
        throw Exception(
          "Gagal mengunduh file. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error saat mengunduh file: $e");
      return null;
    }
  }
}
