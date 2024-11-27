import 'package:get/get.dart';
import 'package:heartrate_database_u_i/app/modules/landing/controllers/landing_controller.dart';

class HomeController extends GetxController {
  final LandingController landingController = Get.find();
  final List<Map<String, dynamic>> about = [
    {
      "label": "Apa itu",
      "title": "Apa Itu HealthCare",
      "content": [
        "Dashboard Penyakit yang memfasilitasi akses data kesehatan bagi peneliti, memungkinkan mereka untuk fokus pada penelitian tanpa harus mengelola data secara manual dengan data yang dikelola oleh instansi terpercaya dan akses yang aman,"
      ]
    },
    {
      "label": "Fitur Aplikasi",
      "title": "Fitur Aplikasi HealthCare",
      "content": [
        "Akses Data yang Lengkap dan Terpercaya \nPeneliti mendapatkan akses ke data penyakit yang telah dikurasi oleh instansi terkait, mencakup berbagai informasi seperti: Detail pasien, Gejala dan diagnosis.Rekam medis, seperti hasil tes atau laporan tambahan.",
        "Penggunaan Data untuk Berbagai Keperluan Penelitian \nData yang tersedia dapat digunakan untuk Menemukan penyakit tertentu, Mengetahui rekam medis dari berbagai penyakit, dll.",
        "Fasilitas Pengunduhan Data \nData yang telah disetujui untuk penelitian dapat diunduh dalam format yang siap digunakan untuk analisis statistik, seperti spreadsheet atau file CSV."
      ]
    },
    {
      "label": "Pengelolaan data",
      "title": "Pengelolaan Data HealthCare",
      "content": [
        "Input Data oleh Instansi \nData penyakit diinput oleh instansi pemegang aplikasi melalui operator yang bertugas. Operator bertanggung jawab untuk memastikan kelengkapan dan keakuratan data sebelum dapat diakses oleh peneliti.",
        "Akses Data oleh Peneliti \nPeneliti hanya dapat mengakses data yang telah disetujui oleh instansi, sehingga keamanan dan integritas data tetap terjaga.",
        "Penyimpanan File Pendukung \nAplikasi juga mendukung penyimpanan file tambahan, seperti hasil scan medis, rekaman tes, atau dokumen lain yang relevan dengan dataset penyakit."
      ]
    },
    {
      "label": "Manfaat",
      "title": "Manfaat HealthCare",
      "content": [
        "Akses Mudah ke Data Berkualitas \nPeneliti dapat langsung menggunakan data yang sudah tersusun tanpa perlu mengumpulkan data sendiri, menghemat waktu dan tenaga.",
        "Privasi dan Keamanan Data \n Sistem berbasis peran memastikan data hanya diakses oleh pihak yang berwenang, menjaga privasi dan keamanan informasi medis.",
        "Kolaborasi dan Validasi \nPeneliti dapat berdiskusi langsung dengan operator untuk mengklarifikasi data, memastikan validitas informasi sebelum digunakan dalam penelitian.",
        "Mendukung Penelitian Berbasis Bukti \nData yang tersedia memungkinkan peneliti untuk melakukan analisis berbasis bukti yang dapat digunakan untuk pengambilan keputusan atau publikasi ilmiah."
      ]
    }
  ];
}
