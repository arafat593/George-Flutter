import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

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
  final RxBool isAboutExpanded = false.obs;

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

  void bookNow() {
    final homeController = Get.find<HomeController>();

    // If price is QAR 0 (covered by membership), show confirmation dialog directly
    if (price.value == 'QAR 0') {
      _showBookingConfirmation();
      return;
    }

    // If user has Class Pack sessions left, show payment method selection
    if (homeController.sessionsLeft.value > 0) {
      _showPaymentMethodDialog();
    } else {
      // Otherwise go to checkout
      Get.toNamed(
        Routes.CHECKOUT,
        arguments: {'title': title.value, 'price': price.value},
      );
    }
  }

  void _showPaymentMethodDialog() {
    final homeController = Get.find<HomeController>();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xffF3EFE9),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Payment Method",
              style: TextStyle(
                color: Color(0xFF5D4037),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildPaymentOption(
              title: "Class Pack Session",
              subtitle:
                  "${homeController.sessionsLeft.value} sessions remaining",
              icon: Icons.confirmation_number_outlined,
              onTap: () {
                Get.back(); // Close bottom sheet
                _useClassPackSession();
              },
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              title: "Pay with Wallet / Card",
              subtitle: "Proceed to checkout",
              icon: Icons.payment_outlined,
              onTap: () {
                Get.back(); // Close bottom sheet
                Get.toNamed(
                  Routes.CHECKOUT,
                  arguments: {'title': title.value, 'price': price.value},
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF6D4C41).withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF6D4C41).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF6D4C41)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF5D4037),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _useClassPackSession() {
    final homeController = Get.find<HomeController>();
    if (homeController.sessionsLeft.value > 0) {
      homeController.sessionsLeft.value -= 1;
      _showBookingConfirmation();
    }
  }

  void _showBookingConfirmation() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xffF3EFE9),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFF6D4C41),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Booking Confirmed!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5D4037),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "You have successfully booked\n${title.value}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF8D6E63), fontSize: 14),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.back(); // Go back to classes list
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6D4C41),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Back To Home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void cancelBooking() {
    Get.back();
  }
}
