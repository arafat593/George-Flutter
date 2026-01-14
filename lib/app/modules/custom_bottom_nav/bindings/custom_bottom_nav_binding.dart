import 'package:get/get.dart';

import '../controllers/custom_bottom_nav_controller.dart';

class CustomBottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomBottomNavController>(
      () => CustomBottomNavController(),
    );
  }
}
