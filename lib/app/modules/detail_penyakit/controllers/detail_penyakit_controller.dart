import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/disease.dart';
import 'package:heartrate_database_u_i/app/models/disease/record/record.dart';
import 'package:heartrate_database_u_i/utils/api/disease/disease_service.dart';
import 'package:heartrate_database_u_i/utils/api/disease/record/disease_record.dart';

class DetailPenyakitController extends GetxController {
  // Mendeklarasikan variabel yang akan menampung data penyakit
  final penyakitDetail = Rx<Disease?>(null); // Gunakan Rx untuk reaktif
  final isLoading = false.obs;

  final hasError = false.obs;
  final recordList = <RecordDetail?>[].obs;
  final penyakitId = Get.arguments;
  final currentPage = 1.obs;
  final hasMorePages = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Memanggil metode untuk mengambil detail penyakit menggunakan ID dari arguments
    ; // Ambil langsung ID penyakit
    if (penyakitId != null) {
      fetchDetailPenyakit(penyakitId);
    }
  }

  Future<void> fetchDetailPenyakit(int id) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      // Memanggil API untuk mengambil detail penyakit
      penyakitDetail.value = await DiseaseService().getDetailDisease(id);
      await fetchRecord(id);
    } catch (e) {
      hasError.value = true;
      print("Error fetching disease details: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRecord(int id, {bool loadMore = false}) async {
    if (!hasMorePages.value && loadMore)
      return; // Jika tidak ada lagi halaman, hentikan
    try {
      if (loadMore) {
      } else {
        recordList.clear();
        currentPage.value = 1;
      }

      final response = await DiseaseRecordService()
          .getAllDiseaseRecord(id, page: currentPage.value);
      print(response);
      recordList.addAll(response.records);

      hasMorePages.value = response.hasMorePages;
      if (response.hasMorePages) {
        currentPage.value += 1;
      }
    } catch (e) {
      print(e);
    } finally {}
  }
}
