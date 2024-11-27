import 'package:get/get.dart';

import '../controllers/detail_record_controller.dart';

class DetailRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailRecordController>(
      () => DetailRecordController(),
    );
  }
}
