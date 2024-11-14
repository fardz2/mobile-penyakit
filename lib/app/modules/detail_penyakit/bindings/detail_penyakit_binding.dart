import 'package:get/get.dart';

import '../controllers/detail_penyakit_controller.dart';

class DetailPenyakitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPenyakitController>(
      () => DetailPenyakitController(),
    );
  }
}
