import 'dart:convert';

import 'package:heartrate_database_u_i/app/models/disease/disease.dart';
import 'package:heartrate_database_u_i/app/models/disease/disease_response.dart';
import 'package:heartrate_database_u_i/utils/api/http_service.dart';

class DiseaseService {
  Future<DiseaseResponse> getAllDisease(
      {int page = 1, String searchQuery = ""}) async {
    try {
      // Construct the URL, adding the search query if it's provided
      String url = '/diseases?page=$page';
      if (searchQuery.isNotEmpty) {
        url += '&name=$searchQuery';
      }

      final response = await HttpService.getRequest(url, includeBearer: true);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == false) {
          throw Exception('Pengguna tidak disetujui: ${data['message']}');
        }

        return DiseaseResponse.fromJson(data);
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
