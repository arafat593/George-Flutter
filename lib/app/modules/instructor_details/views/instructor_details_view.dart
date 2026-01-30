import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/instructor_details_controller.dart';

class InstructorDetailsView extends GetView<InstructorDetailsController> {
  const InstructorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 450.h,
            child: Image.network(
              'https://images.unsplash.com/photo-1594824476967-48c8b964273f?auto=format&fit=crop&q=80&w=1000',
              fit: BoxFit.cover,
              cacheHeight: 600,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),

          // Content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 400.h)),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
                  ),
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sarah Jenkins',
                            style: AppTextStyles.bold(
                              24,
                              color: const Color(0xFF6B5345),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3EFE9),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: const Color(0xFFBCB1AA),
                              ),
                            ),
                            child: Text(
                              'Prenatal Yoga Certified',
                              style: AppTextStyles.medium(
                                10,
                                color: const Color(0xFF6B5345),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Bio',
                        style: AppTextStyles.bold(
                          20,
                          color: const Color(0xFF6B5345),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Certified Hatha Yoga instructor with 10 years of experience focusing on mindfulness and breath.',
                        style: AppTextStyles.regular(
                          14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        'Upcoming Classes',
                        style: AppTextStyles.bold(
                          20,
                          color: const Color(0xFF6B5345),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildClassCard(),
                      _buildClassCard(),
                      _buildClassCard(),
                      _buildClassCard(),
                      _buildClassCard(),
                      SizedBox(height: 50.h),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Back Button
          Positioned(
            top: 50.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.r),
                  Text(
                    'Back',
                    style: AppTextStyles.bold(16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFE8DED3),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  'Beginner',
                  style: AppTextStyles.medium(12, color: Colors.grey),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'QAR 200',
                    style: AppTextStyles.bold(
                      20,
                      color: const Color(0xFF6B5345),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.male,
                        size: 18.r,
                        color: const Color(0xFF6B5345),
                      ),
                      Icon(
                        Icons.female,
                        size: 18.r,
                        color: const Color(0xFF6B5345),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => Get.toNamed(
              Routes.COURSE_DETAILS,
              arguments: {
                'title': 'Morning Vinyasa Flow',
                'price': 'QAR 200',
                'instructorName': 'Sarah Jenkins',
              },
            ),
            child: Text(
              'Morning Vinyasa Flow',
              style: AppTextStyles.medium(18, color: const Color(0xFF6B5345)),
            ),
          ),
          SizedBox(height: 12.h),
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
                'Sarah Jenkins',
                style: AppTextStyles.medium(14, color: const Color(0xFF6B5345)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed(
                  Routes.COURSE_DETAILS,
                  arguments: {
                    'title': 'Morning Vinyasa Flow',
                    'price': 'QAR 200',
                    'instructorName': 'Sarah Jenkins',
                  },
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: const Color(0xFF6B5345),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dec 10, 2025',
                        style: AppTextStyles.regular(10, color: Colors.grey),
                      ),
                      Text(
                        '07:00 AM to 08:30 AM',
                        style: AppTextStyles.medium(
                          12,
                          color: const Color(0xFF6B5345),
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
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 0.8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF6B5345),
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
    );
  }
}
