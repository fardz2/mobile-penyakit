import 'dart:convert';
import 'package:heartrate_database_u_i/app/models/user/User.dart';
import 'package:heartrate_database_u_i/utils/api/http_service.dart';
import 'package:heartrate_database_u_i/utils/storage_service.dart';

class AuthService {
  Future<void> login(String email, String password) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };

      final response = await HttpService.postRequest('/auth/login', body: body);

      if (response.statusCode == 200) {
        print('Login sukses');

        var data = json.decode(response.body);
        var token = data['data']['token'];

        if (token != null) {
          StorageService.saveToken('auth_token', token);
          print('Token berhasil disimpan: $token');
        } else {
          throw Exception('Token tidak ditemukan dalam response');
        }
      } else {
        print(response.body);
        throw Exception('Login gagal: ${response.statusCode}');
      }
    } catch (e) {
      // Menangani error lainnya dan melempar exception lebih lanjut
      print('Terjadi kesalahan: $e');
      throw Exception('Terjadi kesalahan saat proses login: $e');
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String institution,
    required String gender,
    required String phoneNumber,
    required String institusi,
    required String tujuanPermohonan,
  }) async {
    try {
      print(institusi);
      final body = {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'institution': institusi,
        'gender': gender,
        'phone_number': phoneNumber,
        'tujuan_permohonan': tujuanPermohonan,
      };

      final response =
          await HttpService.postRequest('/auth/register', body: body);

      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.body);
        throw Exception('Registrasi gagal: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getProfile() async {
    try {
      final response =
          await HttpService.getRequest('/users/profile', includeBearer: true);
      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if (data['success'] == false) {
          throw Exception('Pengguna tidak disetujui: ${data['message']}');
        }

        return User.fromJson(data['data']);
      } else {
        throw data['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
