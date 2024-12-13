import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/models/disease/disease.dart';
import 'package:heartrate_database_u_i/app/modules/landing/controllers/landing_controller.dart';
import 'package:heartrate_database_u_i/app/modules/profile/controllers/profile_controller.dart';
import 'package:heartrate_database_u_i/utils/api/disease/disease_service.dart';

class HomeController extends GetxController {
  final LandingController landingController = Get.find();
  final ProfileController profileController = Get.find();
  final penyakitList = <Disease>[].obs;
  final errorMessage = ''.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPenyakit(); // Fetch penyakit when the controller is initialized
  }

  final List<Map<String, dynamic>> about = [
    {
      "icon": "assets/icons/svg/apaitu.svg",
      "label": "Apa itu",
      "title": "Apa Itu HealthCare",
      "content": [
        "Dashboard Penyakit yang memfasilitasi akses data kesehatan bagi peneliti, memungkinkan mereka untuk fokus pada penelitian tanpa harus mengelola data secara manual dengan data yang dikelola oleh instansi terpercaya dan akses yang aman."
      ]
    },
    {
      "icon": "assets/icons/svg/fitur.svg",
      "label": "Fitur\nAplikasi",
      "title": "Fitur Aplikasi HealthCare",
      "content": [
        "Akses Data yang Lengkap dan Terpercaya \nPeneliti mendapatkan akses ke data penyakit yang telah dikurasi oleh instansi terkait, mencakup berbagai informasi seperti: Detail pasien, Gejala dan diagnosis, Rekam medis, seperti hasil tes atau laporan tambahan.",
        "Penggunaan Data untuk Berbagai Keperluan Penelitian \nData yang tersedia dapat digunakan untuk Menemukan penyakit tertentu, Mengetahui rekam medis dari berbagai penyakit, dll.",
        "Fasilitas Pengunduhan Data \nData yang telah disetujui untuk penelitian dapat diunduh dalam format yang siap digunakan untuk analisis statistik, seperti spreadsheet atau file CSV."
      ]
    },
    {
      "icon": "assets/icons/svg/pengelolaan.svg",
      "label": "Pengelolaan\ndata",
      "title": "Pengelolaan Data HealthCare",
      "content": [
        "Input Data oleh Instansi \nData penyakit diinput oleh instansi pemegang aplikasi melalui operator yang bertugas. Operator bertanggung jawab untuk memastikan kelengkapan dan keakuratan data sebelum dapat diakses oleh peneliti.",
        "Akses Data oleh Peneliti \nPeneliti hanya dapat mengakses data yang telah disetujui oleh instansi, sehingga keamanan dan integritas data tetap terjaga.",
        "Penyimpanan File Pendukung \nAplikasi juga mendukung penyimpanan file tambahan, seperti hasil scan medis, rekaman tes, atau dokumen lain yang relevan dengan dataset penyakit."
      ]
    },
    {
      "icon": "assets/icons/svg/manfaat.svg",
      "label": "Manfaat",
      "title": "Manfaat HealthCare",
      "content": [
        "Akses Mudah ke Data Berkualitas \nPeneliti dapat langsung menggunakan data yang sudah tersusun tanpa perlu mengumpulkan data sendiri, menghemat waktu dan tenaga.",
        "Privasi dan Keamanan Data \nSistem berbasis peran memastikan data hanya diakses oleh pihak yang berwenang, menjaga privasi dan keamanan informasi medis.",
        "Kolaborasi dan Validasi \nPeneliti dapat berdiskusi langsung dengan operator untuk mengklarifikasi data, memastikan validitas informasi sebelum digunakan dalam penelitian.",
        "Mendukung Penelitian Berbasis Bukti \nData yang tersedia memungkinkan peneliti untuk melakukan analisis berbasis bukti yang dapat digunakan untuk pengambilan keputusan atau publikasi ilmiah."
      ]
    }
  ];

  Future<void> fetchPenyakit(
      {bool loadMore = false, String searchQuery = ""}) async {
    try {
      isLoading(true); // Set isLoading to true when starting to fetch data
      penyakitList.clear();
      errorMessage.value = ''; // Reset errorMessage

      // Call the service to get all diseases
      final response = await DiseaseService().getAllDisease(page: 1);

      // Filter out new diseases that are not already in the list
      final newDiseases = response.diseases.where((newDisease) {
        return !penyakitList
            .any((existingDisease) => existingDisease.id == newDisease.id);
      }).toList();

      // Limit to only the first 4 diseases
      if (newDiseases.length > 4) {
        newDiseases.removeRange(4, newDiseases.length); // Keep only the first 4
      }

      penyakitList.addAll(newDiseases);
      profileController.loadProfile();
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false); // Set isLoading to false after data is loaded
    }
  }
}
