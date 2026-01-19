import 'package:get/get.dart';

class CourseDetailsController extends GetxController {
  final RxBool isInitialized = false.obs;

  // Example data
  final RxString imageUrl =
      'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1000'
          .obs;
  final RxString instructorImage = 'https://i.pravatar.cc/150?img=32'.obs;
  final RxString mapImage =
      'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?auto=format&fit=crop&q=80&w=1000'
          .obs;
  final RxString title = 'Morning Vinyasa Flow'.obs;
  final RxString price = 'QAR 200'.obs;
  final RxString instructorName = 'Sarah Jenkins'.obs;
  final RxBool fromHistory = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Safely get arguments or use defaults
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      imageUrl.value = args['imageUrl'] ?? imageUrl.value;
      instructorImage.value = args['instructorImage'] ?? instructorImage.value;
      mapImage.value = args['mapImage'] ?? mapImage.value;
      title.value = args['title'] ?? title.value;
      price.value = args['price'] ?? price.value;
      instructorName.value = args['instructorName'] ?? instructorName.value;
      fromHistory.value = args['fromHistory'] ?? false;
    }

    Future.delayed(const Duration(milliseconds: 300), () {
      isInitialized.value = true;
    });
  }

  void cancelBooking() {
    Get.toNamed('/checkout');
  }
}
