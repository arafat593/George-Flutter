import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                itemCount: controller.newsItems.length,
                itemBuilder: (context, index) {
                  final item = controller.newsItems[index];
                  return _buildNewsCard(item);
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 20.r,
                  color: AppColors.headlineColor,
                ),
                Text(
                  'Back',
                  style: AppTextStyles.semiBold(
                    20,
                    color: AppColors.headlineColor,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            'News',
            style: AppTextStyles.bold(28, color: AppColors.headlineColor),
          ),
          const Spacer(),
          // Invisible box to balance the back button for centering
          SizedBox(width: 80.w),
        ],
      ),
    );
  }

  Widget _buildNewsCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => Get.toNamed('/news-details', arguments: item),
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  item['image'],
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cacheHeight: 400, // Optimize memory
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180.h,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.broken_image),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 180.h,
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['date'],
                    style: AppTextStyles.regular(
                      12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item['title'],
                    style: AppTextStyles.bold(
                      18,
                      color: AppColors.headlineColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    item['description'],
                    style: AppTextStyles.regular(
                      14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
