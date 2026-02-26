import 'package:flutter/material.dart';
import 'package:george/models/all_courses_model.dart';
import 'package:george/services/api/courses_service.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';

class CourseDetailsController extends GetxController {
  final CoursesService _service = CoursesService();

  // ─── State ───────────────────────────────────────────────
  final RxBool isLoading = true.obs;
  final Rxn<Courses> course = Rxn<Courses>();

  // UI state
  final RxBool isAboutExpanded = false.obs;
  final RxBool fromHistory = false.obs;

  // Price (membership logic)
  final RxString displayPrice = ''.obs;

  // ─── Lifecycle ───────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _loadArguments();
    _fetchCourseDetails();
  }

  void _loadArguments() {
    final args = Get.arguments;

    // CoursesView থেকে দুইভাবে argument আসতে পারে:
    // 1) শুধু course.id (String)
    // 2) Map { 'id': ..., 'title': ..., 'price': ... }
    if (args is Map<String, dynamic>) {
      fromHistory.value = args['fromHistory'] ?? false;
      // price আগে থেকে set করে রাখি (membership সহ)
      if (args['price'] != null) {
        displayPrice.value = args['price'];
      }
    }
  }

  String? get _courseId {
    final args = Get.arguments;
    if (args is String) return args;
    if (args is Map<String, dynamic>) return args['id']?.toString();
    return null;
  }

  Future<void> _fetchCourseDetails() async {
    try {
      isLoading(true);

      final id = _courseId;
      if (id == null || id.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAndToNamed(Routes.notFoundScreen);
        });
        return;
      }

      final result = await _service.getCourseDetails(id);

      if (result != null) {
        course.value = result;

        // displayPrice শুধু তখনই override করব যদি আগে set না থাকে
        if (displayPrice.value.isEmpty) {
          displayPrice.value = 'QAR ${result.price.toStringAsFixed(0)}';
        }
      }
    } catch (e) {
      print("CourseDetailsController Error: $e");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAndToNamed(Routes.errorScreen);
      });
    } finally {
      isLoading(false);
    }
  }

  // ─── Computed Helpers ────────────────────────────────────
  double get seatPercentage {
    final c = course.value;
    if (c == null || c.totalSeat == 0) return 0.0;
    return (c.availableSeat / c.totalSeat).clamp(0.0, 1.0);
  }

  String get formattedDate {
    final date = course.value?.scheduledAt;
    if (date == null) return '—';
    return "${date.day}-${date.month}-${date.year}";
  }

  String get formattedDateLong {
    final date = course.value?.scheduledAt;
    if (date == null) return '—';
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return "${months[date.month]} ${date.day}, ${date.year}";
  }

  // ─── Actions ─────────────────────────────────────────────
  void bookNow() {
    final homeController = Get.find<HomeController>();

    if (displayPrice.value == 'QAR 0') {
      _showBookingConfirmation();
      return;
    }

    if (homeController.sessionsLeft.value > 0) {
      _showPaymentMethodDialog();
    } else {
      Get.toNamed(
        Routes.checkout,
        arguments: {
          'title': course.value?.title ?? '',
          'price': displayPrice.value,
        },
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
                Get.back();
                _useClassPackSession();
              },
            ),
            const SizedBox(height: 16),
            _buildPaymentOption(
              title: "Pay with Wallet / Card",
              subtitle: "Proceed to checkout",
              icon: Icons.payment_outlined,
              onTap: () {
                Get.back();
                Get.toNamed(
                  Routes.checkout,
                  arguments: {
                    'title': course.value?.title ?? '',
                    'price': displayPrice.value,
                  },
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
          border: Border.all(
            color: const Color(0xFF6D4C41).withValues(alpha: 0.1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF6D4C41).withValues(alpha: 0.1),
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
              Obx(
                    () => Text(
                  "You have successfully booked\n${course.value?.title ?? ''}",
                  textAlign: TextAlign.center,
                  style:
                  const TextStyle(color: Color(0xFF8D6E63), fontSize: 14),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
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

  void cancelBooking() => Get.back();
}