import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../courses/controllers/courses_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../store/controllers/store_controller.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../controllers/custom_bottom_nav_controller.dart';

class CustomBottomNavBinding extends BindingsInterface {
  @override
  void dependencies() {
    Get.lazyPut<CustomBottomNavController>(() => CustomBottomNavController());
    // Get.put<FilterController>(FilterController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CoursesController>(() => CoursesController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<StoreController>(() => StoreController());
    Get.lazyPut<WalletController>(() => WalletController());
  }
}
