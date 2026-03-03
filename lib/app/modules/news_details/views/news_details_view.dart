import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/app_image/app_image.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../controllers/news_details_controller.dart';

class NewsDetailsView extends GetView<NewsDetailsController> {
  const NewsDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _buildBackgroundImage(),
          _buildTopHeader(),
          _buildDetailsSheet(),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return Positioned(
      top: 50.h,
      left: 16.w,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: AppColors.headlineColor,
              size: 20.r,
            ),
            Text(
              'Back',
              style: AppTextStyles.bold(16, color: AppColors.headlineColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 450.h,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppImage(
            url: "",
            path: "assets/images/network_placeholder_image.jpg",
            fit: BoxFit.cover,
          ),

          // Dark overlay
          Container(color: Colors.black.withValues(alpha: 0.4)),
        ],
      ),
    );
  }

  Widget _buildDetailsSheet() {
    const Color sheetBg = Color(0xFFF1E9E0);
    const Color brownColor = Color(0xFF6B5345);
    final bool isBookable = controller.item['isBookable'] ?? false;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.55,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.6, 0.95],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: sheetBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 30.h),
            children: [
              _buildDragHandle(),
              _buildHeaderSection(brownColor),
              SizedBox(height: 10.h),
              if (isBookable) _buildLevelTag(brownColor),
              if (isBookable) SizedBox(height: 16.h),
              _buildAboutSection(brownColor),
              SizedBox(height: 20.h),
              if (isBookable) _buildDateTimeSection(brownColor),
              if (isBookable) SizedBox(height: 24.h),
              if (isBookable) _buildInstructorSection(brownColor),
              if (isBookable) SizedBox(height: 24.h),
              if (isBookable) _buildLocationSection(),
              if (isBookable) SizedBox(height: 24.h),
              if (isBookable) _buildBookNowButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Color brownColor) {
    final bool isBookable = controller.item['isBookable'] ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.item['date'] ?? 'Wed Dec 10 2025',
          style: AppTextStyles.regular(
            12,
            color: brownColor.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                controller.item['title'] ?? 'New Morning Yoga Classes Added',
                style: AppTextStyles.bold(22, color: brownColor),
              ),
            ),
            if (isBookable)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.male_outlined, size: 24.r, color: brownColor),
                      Icon(
                        Icons.female_outlined,
                        size: 24.r,
                        color: brownColor,
                      ),
                    ],
                  ),
                  Text(
                    controller.item['price'] ?? 'QAR 200',
                    style: AppTextStyles.bold(24, color: brownColor),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelTag(Color brownColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFFE5D6C9),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'Beginner',
          style: AppTextStyles.medium(12, color: brownColor),
        ),
      ),
    );
  }

  Widget _buildAboutSection(Color brownColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Class', style: AppTextStyles.bold(18, color: brownColor)),
        SizedBox(height: 12.h),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.item['description'] ??
                    'A dynamic flow class to wake up your body and mind. Synchronize breath with movement in this energizing session suited for those with some yoga experience. We will explore various postures and sequences designed to improve flexibility and strength.',
                maxLines: controller.isExpanded.value ? null : 3,
                overflow: controller.isExpanded.value
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
                style: AppTextStyles.regular(
                  14,
                  color: brownColor.withValues(alpha: 0.8),
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => controller.toggleExpanded(),
                child: Text(
                  controller.isExpanded.value ? 'See less' : 'See more',
                  style: AppTextStyles.bold(14, color: brownColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection(Color brownColor) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          size: 20.r,
          color: brownColor.withValues(alpha: 0.6),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            controller.item['time'] ?? '08:00 AM to 08:30 AM',
            style: AppTextStyles.medium(
              14,
              color: brownColor.withValues(alpha: 0.6),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 16.w),
        Icon(
          Icons.calendar_today_outlined,
          size: 20.r,
          color: brownColor.withValues(alpha: 0.6),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            controller.item['date'] ?? 'October 20, 2025',
            style: AppTextStyles.medium(
              14,
              color: brownColor.withValues(alpha: 0.6),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructorSection(Color brownColor) {
    return Row(
      children: [
        ClipOval(
          child: AppImage(
            url: 'https://i.pravatar.cc/150?img=32',
            path: "assets/images/network_placeholder_image.jpg",
            width: 52.r, // radius * 2
            height: 52.r,
            fit: BoxFit.cover,
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
                color: brownColor.withValues(alpha: 0.6),
              ),
            ),
            Text(
              'Sarah Jenkins',
              style: AppTextStyles.medium(18, color: brownColor),
            ),
          ],
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: () => Get.toNamed(Routes.instructorDetails),
          style: ElevatedButton.styleFrom(
            backgroundColor: brownColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            elevation: 0,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          ),
          child: Text(
            'View Profile',
            style: AppTextStyles.bold(12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    const Color textColor = Color(0xFF6B5345);
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F2EF),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Location', style: AppTextStyles.bold(18, color: textColor)),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: AppImage(
              url: '',
              networkPlaceholderImage:
                  "assets/images/network_placeholder_image.jpg", // fallback asset
              height: 160.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          _buildLocationButtons(),
        ],
      ),
    );
  }

  Widget _buildLocationButtons() {
    const Color brownColor = Color(0xFF6B5345);
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: const Color(0xFFDCC8B8),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: brownColor.withValues(alpha: 0.1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call_outlined, size: 20.r, color: brownColor),
                SizedBox(width: 8.w),
                const Text(
                  'Call Studio',
                  style: TextStyle(
                    color: brownColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: brownColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImagePath.whatappButton, height: 30.r, width: 30.r),
                SizedBox(width: 8.w),
                const Text(
                  'WhatsApp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookNowButton() {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton(
        onPressed: () => controller.bookNow(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B5345),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Book Now',
          style: AppTextStyles.bold(18, color: Colors.white),
        ),
      ),
    );
  }
}
