import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/app_image/app_image.dart';
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonPrimaryColor,
            ),
          );
        }

        final aboutUs = controller.aboutUs.value;

        final ourStory = aboutUs?.ourStory ?? 'Nothing Added';
        final ourMission = aboutUs?.ourMission ?? 'Nothing Added';
        final location = aboutUs?.location ?? 'Nothing location Added';
        final email = aboutUs?.email ?? 'Nothing email Added';
        final phone = aboutUs?.phoneNumber ?? 'Nothing number Added';
        final instaId = aboutUs?.instagramAccount ?? 'Nothing Id Added';
        final activeMember = aboutUs?.activeMembers ?? 0;
        final totalClasses = aboutUs?.totalClasses ?? 0;
        final totalInstructor = aboutUs?.totalInstructors ?? 0;

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatsRow(
                      activeMember: activeMember,
                      instructor: totalInstructor,
                      totalClasses: totalClasses,
                    ),
                    Text(
                      'About Us',
                      style: AppTextStyles.semiBold24.apply(
                        color: const Color(0xFF6D4C41),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildSectionTitle("Our story"),
                    SizedBox(height: 8.h),
                    Text(
                      ourStory,
                      style: AppTextStyles.regular(14).copyWith(
                        color: const Color(0xFF6D4C41).withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    _buildSectionTitle("Our Mission"),
                    SizedBox(height: 8.h),
                    Text(
                      ourMission,
                      style: AppTextStyles.regular(14).copyWith(
                        color: const Color(0xFF6D4C41).withValues(alpha: 0.8),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    _buildLocationCard(),
                    SizedBox(height: 24.h),
                    _buildContactInfo(
                      email: email,
                      id: instaId,
                      location: location,
                      phone: phone,
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        AppImage(
          url: "https://picsum.photos/seed/yoga_pose/800/600",
          width: AppSize.size.width,
          height: 300.h,
          fit: BoxFit.cover,
          path: "assets/images/network_placeholder_image.jpg",
        ),
        Container(
          width: AppSize.size.width,
          height: 300.h,
          color: Colors.black.withValues(alpha: 0.2),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white600.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.bodyTextColor,
                        size: 20.r,
                      ),
                      Text(
                        'Back',
                        style: AppTextStyles.bold(
                          16,
                          color: AppColors.bodyTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow({
    required int activeMember,
    required int totalClasses,
    required int instructor,
  }) {
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
          _buildStatCard(activeMember, "Active members"),
          _buildStatCard(totalClasses, "Classes"),
          _buildStatCard(instructor, "Instructors"),
        ],
      ),
    );
  }

  Widget _buildStatCard(int value, String label) {
    return Container(
      width: 100.w,
      height: 80.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value.toString(),
            style: AppTextStyles.bold(
              20,
            ).copyWith(color: const Color(0xFF6D4C41)),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTextStyles.regular(
              10,
            ).copyWith(color: const Color(0xFF6D4C41).withValues(alpha: 0.7)),
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
        color: const Color(0xFFD7CCC8).withValues(alpha: 0.4),
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
            child: AppImage(
              url: "",
              networkPlaceholderImage:
                  "assets/images/network_placeholder_image.jpg",
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

  Widget _buildContactInfo({
    required String location,
    required String email,
    required String phone,
    required String id,
  }) {
    return Column(
      children: [
        _buildContactRow(Icons.location_on_outlined, location),
        SizedBox(height: 12.h),
        _buildContactRow(Icons.email_outlined, email),
        SizedBox(height: 12.h),
        _buildContactRow(
          Icons.phone_outlined,
          phone,
        ), // Using generic phone icon
        SizedBox(height: 12.h),
        _buildContactRow(
          Icons.camera_alt_outlined,
          id,
        ), // Instagram icon approximation
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20.sp, color: const Color(0xFF6D4C41)),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.regular(
              14,
            ).copyWith(color: const Color(0xFF6D4C41).withValues(alpha: 0.8)),
          ),
        ),
      ],
    );
  }
}
