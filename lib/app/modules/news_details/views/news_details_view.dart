import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/news_details_controller.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  const NewsDetailsView({super.key});

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
            height: 400.h,
            child: Image.network(
              controller.item['image'] ??
                  'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1000',
              fit: BoxFit.cover,
              cacheHeight: 400,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade300,
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),

          // Content Scroll View
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 350.h)),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30.r),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.item['date'] ?? 'Wed Dec 10 2025',
                          style: AppTextStyles.regular(14, color: Colors.grey),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          controller.item['title'] ??
                              'New Morning Yoga Classes Added',
                          style: AppTextStyles.bold(
                            24,
                            color: AppColors.headlineColor,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.buttonSecondaryColor.withOpacity(
                              0.3,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Beginner',
                            style: AppTextStyles.medium(
                              12,
                              color: AppColors.headlineColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          controller.item['description'] ??
                              'We are excited to introduce new morning yoga classes designed to help you begin your day with balance and positive energy.\n\nThese sessions focus on gentle stretching, mindful breathing, and simple poses suitable for all levels, including beginners. Regular morning practice can improve flexibility, boost energy levels, and support mental clarity throughout the day.',
                          style: AppTextStyles.regular(
                            14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 100.h), // Space for bottom bar
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Header (Back + Title)
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: 16.r,
                          color: AppColors.headlineColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Back',
                          style: AppTextStyles.medium(
                            14,
                            color: AppColors.headlineColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'News Details',
                        style: AppTextStyles.bold(
                          20,
                          color: AppColors.headlineColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 60.w), // Balance
                ],
              ),
            ),
          ),

          // Bottom Bar (Conditionally shown if title contains 'Added')
          if (controller.item['title']?.toString().contains('Added') ?? false)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(24.r),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20.r,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              controller.item['time'] ?? '8:00-8:30 PM',
                              style: AppTextStyles.medium(
                                14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        if (controller.item['showGenderIcons'] == true)
                          Row(
                            children: [
                              Icon(
                                Icons.male,
                                size: 20.r,
                                color: AppColors.headlineColor,
                              ),
                              Icon(
                                Icons.female,
                                size: 20.r,
                                color: AppColors.headlineColor,
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          controller.item['price'] ?? 'QAR 200',
                          style: AppTextStyles.bold(
                            22,
                            color: AppColors.headlineColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                      width: double.infinity,
                      height: 55.h,
                      child: ElevatedButton(
                        onPressed: () => controller.bookNow(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                        ),
                        child: Text(
                          'Book Now',
                          style: AppTextStyles.bold(18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
