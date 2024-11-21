import 'dart:convert';

import 'package:heartrate_database_u_i/app/models/disease/disease.dart';

import 'package:heartrate_database_u_i/app/models/disease/record/record_response.dart';
import 'package:heartrate_database_u_i/utils/api/http_service.dart';

class DiseaseRecordService {
  Future<RecordResponse> getAllDiseaseRecord(int id, {int page = 1}) async {
    try {
      final response = await HttpService.getRequest(
          '/diseases/$id/records?page=$page',
          includeBearer: true);
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data['success'] == false) {
          throw Exception('Pengguna tidak disetujui: ${data['message']}');
        }
        print(data["data"]["records"]);

        return RecordResponse.fromJson(data);
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
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
