import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                itemCount: 3, // Dummy count
                itemBuilder: (context, index) {
                  return _buildCourseCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Center(
        child: Text(
          'Courses',
          style: AppTextStyles.bold(24, color: AppColors.headlineColor),
        ),
      ),
    );
  }

  Widget _buildCourseCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
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
                      child: Text(
                        'Beginner',
                        style: AppTextStyles.medium(12, color: Colors.grey),
                      ),
                    ),
                    Text(
                      'QAR 200',
                      style: AppTextStyles.bold(
                        20,
                        color: AppColors.headlineColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Morning Vinyasa Flow',
                  style: AppTextStyles.medium(
                    20,
                    color: AppColors.headlineColor,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
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
                          style: AppTextStyles.regular(10, color: Colors.grey),
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
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.toNamed(
                        '/course-details',
                        preventDuplicates: true,
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
                // Replaced DottedLinePainter with a safe Row of dots
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
                        Icon(Icons.access_time, size: 16.r, color: Colors.grey),
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
                          style: AppTextStyles.regular(10, color: Colors.grey),
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
  }
}
