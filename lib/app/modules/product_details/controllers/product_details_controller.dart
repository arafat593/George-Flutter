import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  final count = 1.obs;

  // Mock data that would typically come from arguments or API
  final productArgs = (Get.arguments as Map<String, dynamic>?) ?? {};

  int get availableCount => productArgs['available'] ?? 100;

  late final RxString selectedImage;

  // Mock images for the carousel/thumbnails
  final images = [
    "https://picsum.photos/seed/detail1/500/500",
    "https://picsum.photos/seed/detail2/500/500",
    "https://picsum.photos/seed/detail3/500/500",
  ];

  @override
  void onInit() {
    super.onInit();
    final initialImage = productArgs['image'] ?? images[0];
    selectedImage = initialImage.toString().obs;
  }

  void updateImage(String imageUrl) {
    selectedImage.value = imageUrl;
  }

  void increment() {
    if (count.value < availableCount) {
      count.value++;
    }
  }

  void decrement() {
    if (count.value > 1) {
      count.value--;
    }
  }
}
