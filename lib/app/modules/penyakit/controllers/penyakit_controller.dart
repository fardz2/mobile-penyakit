import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/disease.dart';
import 'package:heartrate_database_u_i/utils/api/disease/disease_service.dart';

class PenyakitController extends GetxController {
  final penyakitList = <Disease>[].obs;
  final isLoading = false.obs;
  final isLoadMore = false.obs;
  final errorMessage = ''.obs;

  final currentPage = 1.obs;
  final hasMorePages = true.obs;

  Future<void> fetchPenyakit({bool loadMore = false}) async {
    if (!hasMorePages.value && loadMore)
      return; // Jika tidak ada lagi halaman, hentikan
    try {
      if (loadMore) {
        isLoadMore(true);
      } else {
        penyakitList.clear();
        currentPage.value = 1;
      }

      final response =
          await DiseaseService().getAllDisease(page: currentPage.value);
      print(response);
      penyakitList.addAll(response.diseases);

      hasMorePages.value = response.hasMorePages;
      if (response.hasMorePages) {
        currentPage.value += 1;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadMore(false);
    }
  }

  Future<void> fetchMorePenyakit() async {
    isLoading(true);
    try {
      await fetchPenyakit(loadMore: false);
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoading(true);
    }
  }

  // Optional: Method to clear error message if necessary
  void clearError() {
    errorMessage.value = '';
  }

  @override
  void onInit() {
    super.onInit();

    fetchMorePenyakit();
  }
}
