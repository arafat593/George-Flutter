import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatsRow(),
                  SizedBox(height: 24.h),
                  _buildSectionTitle("Our story"),
                  SizedBox(height: 8.h),
                  Text(
                    "Founded in 2015, our yoga studio began with a simple vision: to create a sanctuary where everyone could discover the transformative power of yoga.\n\nToday, we're proud to be a thriving community of practitioners, from beginners taking their first steps to advanced yogis deepening their practice.",
                    style: AppTextStyles.regular(14).copyWith(
                      color: const Color(0xFF6D4C41).withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildSectionTitle("Our Mission"),
                  SizedBox(height: 8.h),
                  Text(
                    "We believe yoga is for every body. Our mission is to provide accessible, authentic yoga instruction that honors the ancient traditions while embracing modern needs.",
                    style: AppTextStyles.regular(14).copyWith(
                      color: const Color(0xFF6D4C41).withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  _buildLocationCard(),
                  SizedBox(height: 24.h),
                  _buildContactInfo(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 300.h,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "https://picsum.photos/seed/yoga_pose/800/600",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: 300.h,
            width: double.infinity,
            color: Colors.black.withValues(alpha: 0.4),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        size: 20.sp,
                        color: const Color(0xFF6D4C41),
                      ),
                      Text(
                        "Back",
                        style: AppTextStyles.semiBold(
                          20,
                          color: const Color(0xFF6D4C41),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "About Us",
                      style: AppTextStyles.bold(
                        28,
                        color: const Color(0xFF6D4C41),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 80.w), // Balance back button
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    // The image shows stats cards OVERLAPPING the header image slightly or just below it.
    // The provided design has them floating a bit up. For simplicity I'll put them below the header with a negative offset translation if needed,
    // or just plain below. The image shows them cleanly separated in a row.
    // Actually looking closely at the image, the stats are IN A ROW below the header.
    // Wait, the reference image has stats cards with white background, rounded corners.
    return Transform.translate(
      offset: Offset(0, -40.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatCard("10K+", "Active members"),
          _buildStatCard("500+", "Classes"),
          _buildStatCard("50+", "Instructors"),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 100.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyles.bold(
              20,
            ).copyWith(color: const Color(0xFF6D4C41)),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTextStyles.regular(
              10,
            ).copyWith(color: const Color(0xFF6D4C41).withOpacity(0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bold(18).copyWith(color: const Color(0xFF6D4C41)),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFD7CCC8).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: AppTextStyles.bold(
              16,
            ).copyWith(color: const Color(0xFF6D4C41)),
          ),
          SizedBox(height: 12.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.network(
              "https://picsum.photos/seed/map/600/300",
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildActionButton("Call Studio", Icons.call)),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildActionButton(
                  "WhatsApp",
                  Icons.chat_bubble_outline,
                ), // Approximating whatsapp icon if not available
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    // WhatsApp button is dark in image, Call is light outline/transparent?
    // Actually both look different.
    // Call Studio: Solid outline? Or solid background light brown?
    // WhatsApp: Dark brown solid.
    // Let's approximate based on image.
    final isPrimary = label == "WhatsApp";
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? const Color(0xFF6D4C41)
            : Colors.transparent,
        side: isPrimary ? null : const BorderSide(color: Color(0xFF6D4C41)),
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: isPrimary ? Colors.white : const Color(0xFF6D4C41),
          ),
          SizedBox(width: 8.w),
          Text(
            label,
            style: AppTextStyles.medium(14).copyWith(
              color: isPrimary ? Colors.white : const Color(0xFF6D4C41),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      children: [
        _buildContactRow(
          Icons.location_on_outlined,
          "8502 Preston Rd. Inglewood, Maine 98380",
        ),
        SizedBox(height: 12.h),
        _buildContactRow(Icons.email_outlined, "michael.mitc@example.com"),
        SizedBox(height: 12.h),
        _buildContactRow(
          Icons.phone_outlined,
          "(201) 555-0124",
        ), // Using generic phone icon
        SizedBox(height: 12.h),
        _buildContactRow(
          Icons.camera_alt_outlined,
          "Inara_Yoga",
        ), // Instagram icon approximation
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: const Color(0xFF6D4C41)),
        SizedBox(width: 12.w),
        Text(
          text,
          style: AppTextStyles.regular(
            14,
          ).copyWith(color: const Color(0xFF6D4C41).withOpacity(0.8)),
        ),
      ],
    );
  }
}
