import 'dart:math';

import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/disease.dart';
import 'package:heartrate_database_u_i/app/models/disease/record/record_response.dart'; // Import untuk RecordResponse
import 'package:heartrate_database_u_i/utils/api/disease/disease_service.dart';
import 'package:heartrate_database_u_i/utils/api/disease/record/disease_record.dart';

class DetailPenyakitController extends GetxController {
  // Variabel untuk menyimpan detail penyakit
  final penyakitDetail = Rx<Disease?>(null); // Detail penyakit
  final recordList = RxList<RecordDetail>([]); // Daftar rekam medis

  final schema = Rx<List<Schema>?>(null); // Schema dari API

  // State management
  final isLoading = false.obs; // Status loading
  final isFetching = false.obs; // Status permintaan data berikutnya
  final hasError = false.obs; // Status error
  final hasMorePages = true.obs; // Status halaman berikutnya
  final currentPage = 1.obs; // Halaman saat ini
  final exportUrl = "".obs;

  // ID penyakit dari argument
  final penyakitId = Get.arguments; // Ambil ID penyakit dari arguments

  @override
  void onInit() {
    super.onInit();
    // Jika ada ID penyakit, fetch data detail dan rekam medis
    if (penyakitId != null) {
      fetchDetailPenyakit(penyakitId);
    }
  }

  /// Fungsi untuk mengambil detail penyakit
  Future<void> fetchDetailPenyakit(int id) async {
    try {
      isLoading.value = true; // Set loading ke true
      hasError.value = false; // Reset status error

      // Ambil data detail penyakit
      penyakitDetail.value = await DiseaseService().getDetailDisease(id);

      // Ambil data rekam medis setelah detail berhasil
      await fetchRecord(id);
    } catch (e) {
      hasError.value = true; // Tandai error
      print("Error fetching disease details: $e");
    } finally {
      isLoading.value = false; // Set loading ke false
    }
  }

  /// Fungsi untuk mengambil rekam medis dari API
  Future<void> fetchRecord(int id, {bool loadMore = false}) async {
    // Jika tidak ada halaman berikutnya atau sedang memuat, hentikan
    if (isFetching.value || !hasMorePages.value) return;

    try {
      isFetching.value = true; // Tandai sedang memuat data

      if (!loadMore) {
        // Reset data jika tidak dalam mode loadMore
        recordList.value.clear();
        currentPage.value = 1;
      }

      // Panggil API untuk mendapatkan rekam medis
      final response = await DiseaseRecordService().getAllDiseaseRecord(
        id,
        page: currentPage.value,
      );
      exportUrl.value = response.exportUrl;

      // Tambahkan data record ke dalam list
      recordList.addAll(response.records);

      // Simpan schema dari response
      schema.value = response.schema;

      // Update status halaman berikutnya
      hasMorePages.value = response.hasMorePages;

      // Jika ada halaman berikutnya, increment currentPage
      if (response.hasMorePages) {
        currentPage.value += 1;
      }
    } catch (e) {
      hasError.value = true; // Tandai error
      print('Error fetching records: $e');
    } finally {
      isFetching.value = false; // Tandai selesai memuat data
    }
  }
}
