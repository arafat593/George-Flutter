import 'package:get/get.dart';

import '../controllers/not_found_screen_controller.dart';

class NotFoundScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotFoundScreenController>(
      () => NotFoundScreenController(),
    );
  }
}
