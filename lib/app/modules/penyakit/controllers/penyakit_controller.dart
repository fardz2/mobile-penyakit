import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/disease.dart';
import 'package:heartrate_database_u_i/app/modules/landing/controllers/landing_controller.dart';
import 'package:heartrate_database_u_i/utils/api/disease/disease_service.dart';

class PenyakitController extends GetxController {
  final penyakitList = <Disease>[].obs;
  final isLoading = false.obs; // Indikator untuk loading
  final isLoadMore = false.obs;
  final errorMessage = ''.obs;

  final currentPage = 1.obs;
  final hasMorePages = true.obs;
  final LandingController landingController = Get.find();

  // Controller dan FocusNode untuk Search
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  Future<void> fetchPenyakit(
      {bool loadMore = false, String searchQuery = ""}) async {
    if (!hasMorePages.value && loadMore)
      return; // Hentikan jika tidak ada lagi halaman
    errorMessage.value = '';
    try {
      if (loadMore) {
        isLoadMore(true);
      } else {
        isLoading(true); // Set isLoading ke true ketika mulai mengambil data
        penyakitList.clear();
        currentPage.value = 1;
      }

      // Call the service with searchQuery if provided
      final response = await DiseaseService().getAllDisease(
        page: currentPage.value,
        searchQuery: searchQuery, // Pass searchQuery to the service
      );

      // Tambahkan hanya data yang baru
      final newDiseases = response.diseases.where((newDisease) {
        return !penyakitList
            .any((existingDisease) => existingDisease.id == newDisease.id);
      }).toList();

      penyakitList.addAll(newDiseases);

      hasMorePages.value = response.hasMorePages;
      if (response.hasMorePages) {
        currentPage.value +=
            1; // Increment the page after successfully fetching
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false); // Set isLoading ke false setelah data selesai dimuat
      isLoadMore(false);
    }
  }

  Future<void> fetchMorePenyakit() async {
    if (isLoading.value) return; // Jangan memuat data lagi jika sedang loading
    isLoadMore(true);
    try {
      await fetchPenyakit(loadMore: true);
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
    } finally {
      isLoadMore(false);
    }
  }

  void clearError() {
    errorMessage.value = '';
  }

  @override
  void onInit() {
    super.onInit();
    landingController.setLogin();
    fetchPenyakit(); // Ambil data saat controller diinisialisasi hanya sekali
  }

  @override
  void onClose() {
    super.onClose();
  }
}
