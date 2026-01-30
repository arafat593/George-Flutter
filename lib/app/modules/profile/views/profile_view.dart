import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 30.h),
              _buildMenuSection(),
              SizedBox(height: 30.h),
              Text(
                "Monthly Attendance",
                style: AppTextStyles.bold(
                  20,
                ).copyWith(color: const Color(0xFF6D4C41)),
              ),
              SizedBox(height: 20.h),
              _buildAttendanceChart(),
              SizedBox(height: 30.h),
              _buildStatsGrid(),
              SizedBox(height: 100.h), // Bottom padding for nav bar
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Avatar
        GestureDetector(
          onTap: controller.pickImage,
          child: Stack(
            children: [
              Obx(() {
                return Container(
                  width: 70.r,
                  height: 70.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: controller.profileImage.value.isNotEmpty
                          ? FileImage(File(controller.profileImage.value))
                                as ImageProvider
                          : const NetworkImage(
                              "https://picsum.photos/seed/profile/200",
                            ),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                );
              }),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.camera_alt, size: 14.r, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 15.w),
        // User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      controller.userName.value,
                      style: AppTextStyles.bold(
                        18,
                      ).copyWith(color: const Color(0xFF6D4C41)),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6D4C41),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Obx(
                      () => Text(
                        controller.membershipType.value,
                        style: AppTextStyles.medium(
                          10,
                        ).copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Obx(
                () => Text(
                  controller.userEmail.value,
                  style: AppTextStyles.regular(
                    12,
                  ).copyWith(color: const Color(0xFF6D4C41).withOpacity(0.7)),
                ),
              ),
            ],
          ),
        ),
        // Edit Icon
        GestureDetector(
          onTap: () => Get.toNamed('/edit-profile'),
          child: Icon(Icons.edit_outlined, size: 24.r, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        _buildMenuItem(
          icon: Icons.edit_note,
          title: "Memberships/ Packages",
          onTap: () => Get.toNamed('/memberships'),
        ),
        _buildDivider(),
        Obx(
          () => _buildMenuItem(
            icon: Icons.notifications,
            title: "App Notifications",
            isToggle: true,
            toggleValue: controller.appNotifications.value,
            onToggle: controller.toggleAppNotifications,
          ),
        ),
        _buildDivider(),
        Obx(
          () => _buildMenuItem(
            icon: Icons.chat_bubble_outline,
            title: "WhatsApp Notifications",
            isToggle: true,
            toggleValue: controller.whatsappNotifications.value,
            onToggle: controller.toggleWhatsappNotifications,
          ),
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.book,
          title: "My Bookings",
          onTap: () => Get.toNamed(Routes.MY_BOOKINGS),
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.shield_outlined,
          title: "Order history",
          onTap: () => Get.toNamed(Routes.ORDER_HISTORY),
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.account_balance_wallet_outlined,
          title: "Wallet",
          onTap: () =>
              Get.toNamed(Routes.WALLET, arguments: {'fromProfile': true}),
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.info_outline,
          title: "About INARA",
          onTap: () => Get.toNamed(Routes.ABOUT_US),
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.description_outlined,
          title: "Terms & Conditions",
          onTap: () => Get.toNamed(Routes.TERMS_CONDITIONS),
        ),
        _buildDivider(),
        _buildMenuItem(
          icon: Icons.logout,
          title: "Log Out",
          onTap: () {
            Get.dialog(
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Log Out',
                        style: AppTextStyles.bold(
                          20,
                          color: const Color(0xFF6B5345),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Are you sure you want to log out?',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.regular(
                          14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFDCC8B8),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'No',
                                style: AppTextStyles.bold(
                                  16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => controller.logout(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6B5345),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Text(
                                'Yes',
                                style: AppTextStyles.bold(
                                  16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          showArrow: false,
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool isToggle = false,
    bool toggleValue = false,
    Function(bool)? onToggle,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: isToggle ? null : onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Icon(icon, size: 20.r, color: Colors.grey[600]),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.medium(
                  16,
                ).copyWith(color: const Color(0xFF6D4C41)),
              ),
            ),
            if (isToggle)
              Switch(
                value: toggleValue,
                onChanged: onToggle,
                activeColor: const Color(0xFF6D4C41),
              )
            else if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.r,
                color: const Color(0xFF6D4C41),
              )
            else if (!showArrow && onTap != null && icon == Icons.logout)
              Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(color: const Color(0xFF6D4C41).withOpacity(0.2), height: 1);
  }

  Widget _buildAttendanceChart() {
    return SizedBox(
      height: 200.h,
      child: Obx(() {
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.attendanceData.length,
          separatorBuilder: (context, index) => SizedBox(width: 12.w),
          itemBuilder: (context, index) {
            final data = controller.attendanceData[index];
            final double total = (data['total'] as num).toDouble();
            final double attended = (data['attended'] as num).toDouble();
            final double percentage = attended / (total == 0 ? 1 : total);

            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  data['classes_label'],
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5.h),
                Container(
                  width: 50.w,
                  height: 140.h,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Background Bar
                      Container(
                        width: 50.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBE3D9),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      FractionallySizedBox(
                        heightFactor: percentage.clamp(0.0, 1.0),
                        child: Container(
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6D4C41),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  data['month'],
                  style: AppTextStyles.medium(
                    14,
                  ).copyWith(color: const Color(0xFF6D4C41)),
                ),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.access_time,
                title: "7 Classes Attended",
                subtitle: "Great consistency! Keep up the momentum",
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: _buildStatCard(
                icon: Icons.self_improvement,
                title: "Hatha Yoga",
                subtitle: "You attend this class the most",
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        SizedBox(
          width: double.infinity,
          child: _buildStatCard(
            icon: Icons.person_outline,
            title: "Sarah Jenkins",
            subtitle: "Most attended instructor this month",
            isWide: true,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isWide = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFD7CCC8).withOpacity(0.5), // Light brownish/beige
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24.r, color: const Color(0xFF6D4C41)),
          SizedBox(height: 10.h),
          Text(
            title,
            style: AppTextStyles.bold(
              14,
            ).copyWith(color: const Color(0xFF6D4C41)),
          ),
          SizedBox(height: 5.h),
          Text(
            subtitle,
            style: AppTextStyles.regular(
              10,
            ).copyWith(color: const Color(0xFF6D4C41).withOpacity(0.8)),
          ),
        ],
      ),
    );
  }
}
