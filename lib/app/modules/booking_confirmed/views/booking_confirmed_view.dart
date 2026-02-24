import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/booking_confirmed_controller.dart';
import '../../../routes/app_pages.dart';

class BookingConfirmedView extends GetView<BookingConfirmedController> {
  const BookingConfirmedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3EFE9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildAnimatedSuccessUI(),
              const SizedBox(height: 30),

              Text(
                Get.arguments?['message'] ?? "Payment Confirmed!",
                style: const TextStyle(
                  color: Color(0xFF5D4037),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed(Routes.customBottomNav),
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
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedSuccessUI() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dots - imitating the scattered confetti
          _buildDot(0, -130, color: const Color(0xFF5D4037)), // Top Brown
          _buildDot(60, -110, color: const Color(0xFF5D4037)),
          _buildDot(-60, -110, color: const Color(0xFF5D4037)),
          _buildDot(110, -60, color: const Color(0xFF5D4037)),
          _buildDot(
            -100,
            -70,
            color: const Color(0xFFFF8A80),
            size: 12,
          ), // Pink

          _buildDot(130, 0, color: const Color(0xFF5D4037)),
          _buildDot(-130, 0, color: const Color(0xFF5D4037)),

          _buildDot(100, 70, color: const Color(0xFF5D4037)),
          _buildDot(-100, 80, color: const Color(0xFF5D4037)),
          _buildDot(60, 120, color: const Color(0xFFFF8A80), size: 12), // Pink
          _buildDot(-60, 120, color: const Color(0xFF5D4037)),
          _buildDot(0, 140, color: const Color(0xFFFF8A80), size: 10), // Pink

          _buildDot(40, -150, size: 8, color: const Color(0xFF5D4037)),
          _buildDot(-40, -140, size: 12, color: const Color(0xFF5D4037)),
          _buildDot(80, -90, size: 6, color: const Color(0xFF5D4037)),
          _buildDot(-90, -30, size: 10, color: const Color(0xFF5D4037)),
          _buildDot(90, 30, size: 8, color: const Color(0xFF5D4037)),

          // Main Circle
          Container(
            width: 160,
            height: 160,
            decoration: const BoxDecoration(
              color: Color(0xFF6D4C41), // Dark brown
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.check_rounded, color: Colors.white, size: 90),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(
    double x,
    double y, {
    double size = 14,
    Color color = const Color(0xFF6D4C41),
  }) {
    return Transform.translate(
      offset: Offset(x, y),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}
