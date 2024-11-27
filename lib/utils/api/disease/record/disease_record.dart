import 'dart:convert';

import 'package:heartrate_database_u_i/app/models/disease/disease.dart';

import 'package:heartrate_database_u_i/app/models/disease/record/record_response.dart';
import 'package:heartrate_database_u_i/utils/api/http_service.dart';

class DiseaseRecordService {
  Future<RecordResponse> getAllDiseaseRecord(int id, {int page = 1}) async {
    try {
      final response = await HttpService.getRequest(
        '/diseases/$id/records?page=$page',
        includeBearer: true,
      );

      // Cek apakah status code dari response berhasil (200 OK)
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Validasi apakah response memiliki field 'success' dan nilainya true
        if (data['success'] == true) {
          if (data['data'] != null) {
            // Parsing data menjadi model RecordResponse
            return RecordResponse.fromJson(data);
          } else {
            throw Exception('Data tidak ditemukan');
          }
        } else {
          throw Exception('Error: ${data['message']}');
        }
      } else {
        // Menangani error dari status code selain 200
        final errorData = json.decode(response.body);
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (e) {
      // Penanganan error selama proses pemanggilan API
      print('Error: $e');
      rethrow; // Meneruskan error ke pemanggil
    }
  }

  Future<RecordResponseDetail> getDetailRecord(
      int diseaseId, int recordId) async {
    try {
      final response = await HttpService.getRequest(
        '/diseases/$diseaseId/records/$recordId',
        includeBearer: true,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Validasi apakah response memiliki field 'success' dan nilainya true
        if (data['success'] == true) {
          if (data['data'] != null) {
            return RecordResponseDetail.fromJson(data);
          } else {
            throw Exception('Data tidak ditemukan');
          }
        } else {
          throw Exception('Error: ${data['message']}');
        }
      } else {
        // Menangani error dari status code selain 200
        final errorData = json.decode(response.body);
        throw Exception('Error: ${errorData['message']}');
      }
    } catch (e) {
      // Penanganan error selama proses pemanggilan API
      print('Error: $e');
      rethrow; // Meneruskan error ke pemanggil
    }
  }

  Future<Disease> getDetailDisease(int id) async {
    try {
      final response =
          await HttpService.getRequest('/diseases/$id', includeBearer: true);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == false) {
          throw Exception('Pengguna tidak disetujui: ${data['message']}');
        }

        return Disease.fromJson(data['data']);
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
