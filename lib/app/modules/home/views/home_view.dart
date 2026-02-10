import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../widgets/app_refresh_indicator.dart';
import '../controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../courses/controllers/filter_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: AppRefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                SizedBox(height: 20.h),
                _buildDateSelector(),
                SizedBox(height: 24.h),
                _buildQuickActions(),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text(
                          controller.selectedDateLabel == 'Upcoming Classes'
                              ? 'Upcoming Classes'
                              : "${controller.selectedDateLabel}'s Classes",
                          style: AppTextStyles.bold(
                            24,
                            color: AppColors.headlineColor,
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.selectedDateString,
                          style: AppTextStyles.regular(14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildClassList(),
                SizedBox(height: 125.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/my-bookings'),
            child: Row(
              children: [
                Icon(
                  Icons.menu_book,
                  color: AppColors.headlineColor,
                  size: 24.r,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Bookings',
                  style: AppTextStyles.medium(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            ImagePath.splashImage,
            height: 140.h,
            width: 140.w,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              Obx(() {
                final filterController = Get.find<FilterController>();
                final isFilterActive = filterController.isFilterApplied.value;
                return GestureDetector(
                  onTap: () {
                    filterController.resetTemp();
                    Get.toNamed('/filter');
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: isFilterActive
                          ? AppColors.buttonPrimaryColor
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: isFilterActive
                          ? Border.all(
                              color: AppColors.headlineColor,
                              width: 2.r,
                            )
                          : null,
                    ),
                    child: Image.asset(
                      ImagePath.funnelIcon,
                      height: 20.r,
                      width: 20.r,
                      color: isFilterActive
                          ? Colors.white
                          : AppColors.headlineColor,
                    ),
                  ),
                );
              }),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () => Get.toNamed('/notifications'),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    ImagePath.notification,
                    height: 30.r,
                    width: 20.r,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondaryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: InkWell(
                  onTap: () => controller.handleTodayButtonClick(),
                  child: Text(
                    "Today",
                    style: AppTextStyles.medium(
                      14,
                      color: AppColors.headlineColor,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.previousMonth(),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 14.r,
                          color: AppColors.headlineColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${controller.currentMonthName} ${controller.currentYear}',
                      style: AppTextStyles.medium(
                        14,
                        color: AppColors.headlineColor,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () => controller.nextMonth(),
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.all(8.r),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 14.r,
                          color: AppColors.headlineColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 80.h,
          child: Obx(
            () => ListView.builder(
              controller: controller.scrollController,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: controller.dates.length,
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelected = controller.selectedDateIndex.value == index;
                  var dateItem = controller.dates[index];
                  return GestureDetector(
                    onTap: () => controller.setSelectedDate(index),
                    child: Container(
                      width: 60.w,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.buttonPrimaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? Colors.transparent
                              : Colors.grey.shade400,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dateItem['day'] ?? '',
                            style: AppTextStyles.regular(
                              12,
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            dateItem['date'] ?? '',
                            style: AppTextStyles.bold(
                              16,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.headlineColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _quickActionItem(
            ImagePath.phone,
            'Call Us',
            onTap: _showComingSoonDialog,
          ),
          _quickActionItem(
            ImagePath.whatsapp,
            'WhatsApp',
            onTap: _showComingSoonDialog,
          ),
          _quickActionItem(
            ImagePath.location,
            'Find Us',
            onTap: _showComingSoonDialog,
          ),
          _quickActionItem(
            ImagePath.news,
            'Our News',
            onTap: () => Get.toNamed('/news'),
          ),
        ],
      ),
    );
  }

  void _showComingSoonDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondaryColor.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.hourglass_empty_rounded,
                  color: AppColors.headlineColor,
                  size: 32.r,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Coming Soon!",
                style: AppTextStyles.bold(20, color: AppColors.headlineColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              Text(
                "This feature is currently under development. Stay tuned for updates!",
                style: AppTextStyles.regular(16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimaryColor,
                  minimumSize: Size(double.infinity, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  "OK",
                  style: AppTextStyles.bold(16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quickActionItem(
    String iconPath,
    String label, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(iconPath, fit: BoxFit.contain),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: AppTextStyles.regular(12, color: AppColors.headlineColor),
          ),
        ],
      ),
    );
  }

  Widget _buildClassList() {
    return Obx(() {
      final isPaid = controller.isMembershipPaid.value;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            _classCard(
              badge: 'Beginner',
              title: 'Morning Vinyasa Flow',
              price: isPaid ? 'QAR 0' : 'QAR 200',
              time: '8:00 AM - 8:30 AM',
              instructor: 'Sarah Jenkins',
              status: 'available',
              spots: 2,
              isMembershipPaid: isPaid,
            ),
            SizedBox(height: 16.h),
            _classCard(
              badge: 'Beginner',
              title: 'Morning Vinyasa Flow',
              price: isPaid ? 'QAR 0' : 'QAR 200',
              time: '8:00 AM - 8:30 AM',
              instructor: 'Sarah Jenkins',
              status: 'fully_booked',
              isMembershipPaid: isPaid,
            ),
            SizedBox(height: 16.h),
            _classCard(
              badge: 'Beginner',
              title: 'Morning Vinyasa Flow',
              price: isPaid ? 'QAR 0' : 'QAR 200',
              time: '8:00 AM - 8:30 AM',
              instructor: 'Sarah Jenkins',
              status: 'cancelled',
              isMembershipPaid: isPaid,
            ),
            SizedBox(height: 16.h),
            _classCard(
              badge: 'Advanced',
              title: 'Power Yoga Workshop',
              price: 'QAR 350',
              time: '10:00 AM - 12:30 PM',
              instructor: 'Michael Chen',
              status: 'available',
              spots: 5,
              isMembershipPaid:
                  false, // This card won't have the Membership badge
            ),
          ],
        ),
      );
    });
  }

  Widget _classCard({
    required String badge,
    required String title,
    required String price,
    required String time,
    required String instructor,
    required String status,
    int? spots,
    bool isMembershipPaid = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(200),
                    ),
                    child: Text(
                      badge,
                      style: AppTextStyles.medium(12, color: Colors.grey),
                    ),
                  ),
                  if (isMembershipPaid) ...[
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(200),
                      ),
                      child: Text(
                        'Membership',
                        style: AppTextStyles.medium(12, color: Colors.grey),
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                price,
                style: AppTextStyles.bold(20, color: AppColors.headlineColor),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/course-details',
                    preventDuplicates: true,
                    arguments: {
                      'title': title,
                      'price': price,
                      'fromHistory': status != 'available',
                    },
                  );
                },
                child: Text(
                  title,
                  style: AppTextStyles.medium(
                    18,
                    color: AppColors.headlineColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.male, size: 20.r, color: AppColors.headlineColor),
                  Icon(
                    Icons.female,
                    size: 20.r,
                    color: AppColors.headlineColor,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 15.r,
                    backgroundImage: const NetworkImage(
                      'https://i.pravatar.cc/150?img=32',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    instructor,
                    style: AppTextStyles.regular(
                      14,
                      color: AppColors.headlineColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (status == 'available')
                GestureDetector(
                  onTap: () => Get.toNamed(
                    Routes.COURSE_DETAILS,
                    preventDuplicates: true,
                    arguments: {
                      'title': title,
                      'price': price,
                      'fromHistory': status != 'available',
                    },
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.headlineColor,
                    size: 24.r,
                  ),
                ),
              if (status == 'fully_booked')
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.all(24.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  color: AppColors.buttonSecondaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.notification_add_outlined,
                                  color: AppColors.headlineColor,
                                  size: 32.r,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "You're on the list!",
                                style: AppTextStyles.bold(
                                  20,
                                  color: AppColors.headlineColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                "We'll alert you if a spot becomes available.",
                                style: AppTextStyles.regular(
                                  16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 24.h),
                              ElevatedButton(
                                onPressed: () => Get.back(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.buttonPrimaryColor,
                                  minimumSize: Size(double.infinity, 50.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Text(
                                  "OK",
                                  style: AppTextStyles.bold(
                                    16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.notification_add_outlined,
                    color: AppColors.headlineColor,
                    size: 24.r,
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time, size: 16.r, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text(
                    time,
                    style: AppTextStyles.regular(14, color: Colors.grey),
                  ),
                ],
              ),
              if (status == 'available') ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Available spots $spots',
                      style: AppTextStyles.regular(10, color: Colors.grey),
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      width: 100.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: AppColors.buttonPrimaryColor,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          Positioned(
                            left: 75.w,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 8.r,
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              if (status == 'fully_booked')
                Row(
                  children: [
                    Icon(Icons.group_outlined, size: 18.r, color: Colors.red),
                    SizedBox(width: 4.w),
                    Text(
                      'Fully Booked',
                      style: AppTextStyles.medium(14, color: Colors.red),
                    ),
                  ],
                ),
              if (status == 'cancelled')
                Text(
                  'Cancelled',
                  style: AppTextStyles.medium(14, color: Colors.red),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
