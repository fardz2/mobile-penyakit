import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

  // Menyimpan data ke dalam GetStorage
  static Future<void> saveToken(String name, String token) async {
    print("berhasil");
    await _storage.write(name, token);
  }

  // Mengambil token dari GetStorage
  static String? getToken(String name) {
    return _storage.read(name);
  }

  // Menghapus token dari GetStorage
  static Future<void> clearToken(name) async {
    await _storage.remove(name);
  }
}
