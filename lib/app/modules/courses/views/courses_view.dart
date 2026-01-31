import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/app_refresh_indicator.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/courses_controller.dart';
import '../controllers/filter_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: AppRefreshIndicator(
                onRefresh: () async {
                  // Simulated refresh delay
                  await Future.delayed(const Duration(seconds: 2));
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  itemCount: 3, // Dummy count
                  itemBuilder: (context, index) {
                    // Make the second item (index 1) a non-membership card for variety
                    final bool showBadge = index != 1;
                    return _buildCourseCard(
                      homeController,
                      showBadge: showBadge,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    final filterController = Get.find<FilterController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 38.w), // Balance spacing
          Text(
            'Courses',
            style: AppTextStyles.bold(24, color: AppColors.headlineColor),
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                filterController.resetTemp();
                Get.toNamed(Routes.FILTER);
              },
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: filterController.isFilterApplied.value
                      ? AppColors.buttonPrimaryColor
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: filterController.isFilterApplied.value
                      ? Border.all(color: AppColors.headlineColor, width: 2.r)
                      : null,
                ),
                child: Image.asset(
                  ImagePath.funnelIcon,
                  height: 22.r,
                  width: 22.r,
                  color: filterController.isFilterApplied.value
                      ? Colors.white
                      : AppColors.headlineColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
    HomeController homeController, {
    bool showBadge = true,
  }) {
    return Obx(() {
      final isPaid = homeController.isMembershipPaid.value && showBadge;
      final price = isPaid ? 'QAR 0' : 'QAR 200';

      return Container(
        margin: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(
                Routes.COURSE_DETAILS,
                preventDuplicates: true,
                arguments: {'title': 'Morning Vinyasa Flow', 'price': price},
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: Image.network(
                  'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1000',
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cacheHeight: 300,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180.h,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Beginner',
                              style: AppTextStyles.medium(
                                12,
                                color: Colors.grey,
                              ),
                            ),
                            if (isPaid) ...[
                              SizedBox(width: 8.w),
                              Text(
                                '|  Membership',
                                style: AppTextStyles.medium(
                                  12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Text(
                        price,
                        style: AppTextStyles.bold(
                          20,
                          color: AppColors.headlineColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.COURSE_DETAILS,
                      preventDuplicates: true,
                      arguments: {
                        'title': 'Morning Vinyasa Flow',
                        'price': price,
                      },
                    ),
                    child: Text(
                      'Morning Vinyasa Flow',
                      style: AppTextStyles.medium(
                        20,
                        color: AppColors.headlineColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.INSTRUCTOR_DETAILS),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20.r,
                              backgroundColor: Colors.grey.shade200,
                              child: ClipOval(
                                child: Image.network(
                                  'https://i.pravatar.cc/150?img=32',
                                  fit: BoxFit.cover,
                                  cacheHeight: 100,
                                ),
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
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  'Sarah Jenkins',
                                  style: AppTextStyles.medium(
                                    14,
                                    color: AppColors.headlineColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.toNamed(
                          Routes.COURSE_DETAILS,
                          preventDuplicates: true,
                          arguments: {
                            'title': 'Morning Vinyasa Flow',
                            'price': price,
                          },
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.headlineColor,
                            size: 24.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: List.generate(
                      20,
                      (index) => Expanded(
                        child: Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                          color: index % 2 == 0
                              ? Colors.grey.shade400
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16.r,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dec 10, 2025',
                                style: AppTextStyles.regular(
                                  12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '07:00 AM to 08:30 AM',
                                style: AppTextStyles.medium(
                                  12,
                                  color: AppColors.headlineColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Available spots 2',
                            style: AppTextStyles.regular(
                              10,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 80.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.buttonPrimaryColor,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
