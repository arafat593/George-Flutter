import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final count = 1.obs;

  // Mock data that would typically come from arguments or API
  final productArgs = Get.arguments ?? {};

  // Mock images for the carousel/thumbnails
  final images = [
    "https://picsum.photos/seed/detail1/500/500",
    "https://picsum.photos/seed/detail2/500/500",
    "https://picsum.photos/seed/detail3/500/500",
  ];

  void increment() {
    count.value++;
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }
}
