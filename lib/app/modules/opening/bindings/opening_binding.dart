import 'package:get/get.dart';

import '../controllers/opening_controller.dart';

class OpeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpeningController>(
      () => OpeningController(),
    );
  }
}
