import 'package:get/get.dart';

class NewsDetailsController extends GetxController {
  final Map<String, dynamic> item = Get.arguments ?? {};

  void bookNow() {
    Get.toNamed('/checkout');
  }
}
