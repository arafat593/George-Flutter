import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/app_image/app_image.dart';
import 'package:george/app/widgets/custom_appbar.dart';
import 'package:george/models/news_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/news_controller.dart';

class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'News'),
      body: Obx(() {
        final length = controller.newsData.value?.news.length ?? 0;
        final newsItems = controller.newsData.value?.news ?? [];
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonPrimaryColor,
            ),
          );
        }

        return SafeArea(
          child: newsItems.isEmpty
              ? Center(child: Text('No News Data Found'))
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 10.h,
                  ),
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final item = newsItems[index];
                    return _buildNewsCard(item);
                  },
                ),
        );
      }),
    );
  }

  Widget _buildNewsCard(NewsModel item) {
    String formatDate(DateTime dateTime) {
      String formatted = DateFormat('EE MMMM d, yyyy').format(dateTime);
      return formatted;
    }

    final image = item.thumbnail;
    final formattedDate = formatDate(item.publishedAt);
    final title = item.title;
    final description = item.shortDescription;

    return GestureDetector(
      onTap: () => Get.toNamed('/news-details', arguments: item),
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: AppImage(
                  url: image,
                  networkPlaceholderImage:
                      "assets/images/network_placeholder_image.jpg", // fallback asset
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedDate,
                    style: AppTextStyles.regular(
                      12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    title,
                    style: AppTextStyles.bold(
                      18,
                      color: AppColors.headlineColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description.length > 70
                        ? '${description.substring(0, 70)}...'
                        : description,
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
