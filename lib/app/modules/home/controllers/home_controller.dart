import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final about = "arrythmia".obs;
  final List<Map<String, dynamic>> itemsArrythmia = [
    {
      'title': 'Penyebab Arrythmia',
      'icon': 'assets/icons/svg/Subtract.svg',
      "items": [
        'Masalah pada sistem listrik jantung',
        'Penyakit jantung',
        'Stress atau kecemasan',
        'Efek samping obat-obatan tertentu',
        'Ketidakseimbangan elektrolit dalam tubuh',
      ],
    },
    {
      'title': 'Gejala Arrythmia',
      'icon': 'assets/icons/svg/DNA.svg',
      "items": [
        'Jantung berdebar',
        'Detak jantung terasa cepat atau lambat',
        'Nyeri dada dan Sesak napas',
        'Pusing atau pingsan',
      ],
    },
    {
      'title': 'Pencegahan Arrythmia',
      'icon': 'assets/icons/svg/Mask.svg',
      "items": [
        'Menjalani gaya hidup sehat',
        'Mengelola stress dengan baik',
        'Hindari stimulan berlebihan seperti kafein, alkohol, dan nikotin',
        'Rutin melakukan pemeriksaan kesehatan jantung'
      ],
    },
    {
      'title': 'Pengobatan Arrythmia',
      'icon': 'assets/icons/svg/Pill.svg',
      "items": [
        'Obat ntuk mengendalikan detak jantung',
        'Ablasi kateter untuk menghancurkan jaringan penyebab aritmia',
        'Kardioverter-defibrilator implan (ICD) untuk menghentikan aritmia berbahaya',
        'Perubahan gaya hidup seperti mengurangi stress'
      ],
    },
    {
      'title': 'Dampak Arrythmia',
      'icon': 'assets/icons/svg/Smartwatch-Heart.svg',
      "items": [
        'Kecemasan dan depresi terkait kondisi jantung',
        'Pembatasan aktivitas fisik',
        'Gangguan tidur',
        'Penurunan produktivitas kerja',
        'erubahan dalam hubungan sosial'
      ],
    },
    {
      'title': 'Diagnosis Arrytmia',
      'icon': 'assets/icons/svg/Microscope.svg',
      "items": [
        'Diagnosis aritmia biasanya dilakukan melalui Elektrokardiogram (EKG), Holter monitor, atau tes stress jantung. Pengobatan dapat meliputi obat-obatan, ablasi kateter, atau pemasangan alat pacu jantung, tergantung pada jenis dan tingkat keparahan aritmia.',
      ],
    },
  ];
  final List<Map<String, dynamic>> itemsMyocardial = [
    {
      'title': 'Penyebab Myocardial',
      'icon': 'assets/icons/svg/Subtract.svg',
      "items": [
        'Penumpukan plak di arteri koroner (aterosklerosis)',
        'Pembekuan darah yang menyumbat arteri',
        'Spasme arteri koroner',
        'Tekanan atau trauma pada dada',
      ],
    },
    {
      'title': 'Gejala Myocardial',
      'icon': 'assets/icons/svg/DNA.svg',
      "items": [
        'Nyeri dada atau rasa tidak nyaman',
        'Nyeri yang menyebar ke lengan, leher, rahang, punggung, atau perut',
        'Berkeringat dingin, mual, muntah, dan sesak napas',
      ],
    },
    {
      'title': 'Pencegahan Myocardial',
      'icon': 'assets/icons/svg/Mask.svg',
      "items": [
        'Berhenti merokok dan mengelola stres',
        'Menjaga berat badan ideal dan olahraga teratur',
        'Mengelola tekanan darah dan kolesterol',
        'Mengontrol diabetes (jika ada)',
      ],
    },
    {
      'title': 'Pengobatan Myocardial',
      'icon': 'assets/icons/svg/Pill.svg',
      "items": [
        'Obat-obatan: antiplatelet, penghambat beta, pengencer darah',
        'Angioplasti dan pemasangan stent',
        'Operasi: bypass jantung (untuk kasus berat)',
      ],
    },
    {
      'title': 'Dampak Myocardial',
      'icon': 'assets/icons/svg/Smartwatch-Heart.svg',
      "items": [
        'Perubahan dalam kemampuan fisik',
        'Penyesuaian gaya hidup yang signifikan',
        'Risiko serangan jantung berulang',
        'Perubahan dalam hubungan personal dan profesional',
      ],
    },
    {
      'title': 'Diagnosis Myocardial',
      'icon': 'assets/icons/svg/Microscope.svg',
      "items": [
        'Diagnosis Myocardial Infarction melibatkan pemeriksaan fisik, EKG, tes darah untuk enzim troponin, dan pencitraan jantung untuk memeriksa aliran darah dan keparahan serangan.',
      ],
    },
  ];

  void changeAbout(String value) {
    about.value = value;
  }
}
