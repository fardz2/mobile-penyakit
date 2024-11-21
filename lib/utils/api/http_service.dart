import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:heartrate_database_u_i/utils/storage_service.dart'; // Jika Anda menggunakan StorageService

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

  static Future<http.Response> postRequest(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeBearer =
        false, // Tambahkan parameter untuk menentukan apakah perlu Bearer token
  }) async {
    try {
      final Uri url = Uri.parse('${dotenv.env["API_URL"]}$endpoint');
      final headers = getHeaders(
          includeBearer: includeBearer); // Menggunakan parameter includeBearer
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
      final headers = getHeaders(
          includeBearer: includeBearer); // Menggunakan parameter includeBearer
      final response = await http.get(
        url,
        headers: headers,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
