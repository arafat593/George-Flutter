import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/my_bookings_controller.dart';

class MyBookingsView extends GetView<MyBookingsController> {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            SizedBox(height: 16.h),
            _buildTabs(),
            Expanded(
              child: Obx(() {
                if (controller.selectedTab.value == 0) {
                  return _buildUpcomingList(context);
                } else {
                  return _buildHistoryList();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 18.r,
                  color: const Color(0xFF6B5345),
                ),
                Text(
                  'Back',
                  style: AppTextStyles.medium(
                    16,
                    color: const Color(0xFF6B5345),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            'My Bookings',
            style: AppTextStyles.bold(24, color: const Color(0xFF6B5345)),
          ),
          const Spacer(),
          SizedBox(width: 60.w),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.selectTab(0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: controller.selectedTab.value == 0
                        ? const Color(0xFF6B5345)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      'Upcoming',
                      style: AppTextStyles.bold(
                        16,
                        color: controller.selectedTab.value == 0
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.selectTab(1),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: controller.selectedTab.value == 1
                        ? const Color(0xFF6B5345)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      'History',
                      style: AppTextStyles.bold(
                        16,
                        color: controller.selectedTab.value == 1
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingList(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24.r),
      children: [
        _buildBookingCard(context),
        SizedBox(height: 24.h),
        _buildCancellationRule(),
      ],
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      padding: EdgeInsets.all(24.r),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: _buildHistoryCard(),
        );
      },
    );
  }

  Widget _buildHistoryCard() {
    const Color brownColor = Color(0xFF6B5345);
    const Color cardColor = Color(0xFFE8DED3);

    return GestureDetector(
      onTap: () =>
          Get.toNamed('/course-details', arguments: {'fromHistory': true}),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1000',
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
                cacheHeight: 400,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Dec 10, 2025 at 07:00-08:30 AM',
                    style: AppTextStyles.medium(
                      10,
                      color: brownColor.withOpacity(0.8),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Completed',
                    style: AppTextStyles.medium(
                      10,
                      color: brownColor.withOpacity(0.8),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Morning Vinyasa Flow',
              style: AppTextStyles.bold(20, color: brownColor),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/150?img=32',
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructors',
                      style: AppTextStyles.regular(
                        10,
                        color: brownColor.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      'Sarah Jenkins',
                      style: AppTextStyles.medium(14, color: brownColor),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.r,
                  color: brownColor.withOpacity(0.6),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Studio A - Sun Room',
                  style: AppTextStyles.medium(
                    12,
                    color: brownColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/course-details'),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFFE8DED3),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1000',
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
                cacheHeight: 300,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Dec 10, 2025 at 07:00-08:30 AM',
                    style: AppTextStyles.medium(
                      10,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3EFE9),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Confirmed',
                    style: AppTextStyles.medium(
                      10,
                      color: const Color(0xFF6B5345),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              'Morning Vinyasa Flow',
              style: AppTextStyles.bold(20, color: const Color(0xFF6B5345)),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: const NetworkImage(
                    'https://i.pravatar.cc/150?img=32',
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructors',
                      style: AppTextStyles.regular(10, color: Colors.grey),
                    ),
                    Text(
                      'Sarah Jenkins',
                      style: AppTextStyles.medium(
                        14,
                        color: const Color(0xFF6B5345),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 16.r,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Studio A - Sun Room',
                  style: AppTextStyles.medium(12, color: Colors.grey.shade700),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () => _showCancelConfirmationDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B5345),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Cancel',
                  style: AppTextStyles.bold(16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    _showCustomDialog(
      context,
      title: 'Cancel Booking?',
      subtitle: 'Do you really want to cancel this booking?',
      onYes: () => _showCancellationRuleDialog(context),
    );
  }

  void _showCancellationRuleDialog(BuildContext context) {
    _showCustomDialog(
      context,
      title: 'Cancellation Rule',
      subtitle:
          'Cancellations made within 3 hours of the class start time are non refundable.',
      onYes: () => _showClassCancelledDialog(context),
    );
  }

  void _showClassCancelledDialog(BuildContext context) {
    _showCustomDialog(
      context,
      title: 'Class Cancelled',
      subtitle:
          'Your class has been cancelled successfully. If you need any help, feel free to contact us.',
      onYes: () => Get.back(),
    );
  }

  void _showCustomDialog(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onYes,
  }) {
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
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.close, size: 24.r, color: Colors.grey),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 40.r,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.bold(20, color: const Color(0xFF6B5345)),
              ),
              SizedBox(height: 12.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.regular(14, color: Colors.grey.shade600),
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
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'No',
                        style: AppTextStyles.bold(16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        onYes();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6B5345),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Yes',
                        style: AppTextStyles.bold(16, color: Colors.white),
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
  }

  Widget _buildCancellationRule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cancellation Rule',
          style: AppTextStyles.bold(18, color: const Color(0xFF6B5345)),
        ),
        SizedBox(height: 8.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Container(
                width: 4.r,
                height: 4.r,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Cancellations made within 3 hours of the class start time are non refundable.',
                style: AppTextStyles.regular(14, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
