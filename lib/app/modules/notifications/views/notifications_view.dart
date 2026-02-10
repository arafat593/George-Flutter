import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 10.h,
                  ),
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final item = controller.notifications[index];
                    return _buildNotificationItem(item);
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
            'Notifications',
            style: AppTextStyles.bold(28, color: AppColors.headlineColor),
          ),
          const Spacer(),
          SizedBox(width: 80.w),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> item) {
    bool isUnread = item['isRead'] == false;
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isUnread
            ? const Color(0xFF6B5345)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none,
              size: 24.r,
              color: isUnread ? const Color(0xFF6B5345) : Colors.grey,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['title'],
                      style: AppTextStyles.bold(
                        16,
                        color: isUnread
                            ? Colors.white
                            : AppColors.headlineColor,
                      ),
                    ),
                    Text(
                      item['time'],
                      style: AppTextStyles.regular(
                        10,
                        color: isUnread ? Colors.white70 : Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  item['subtitle'],
                  style: AppTextStyles.regular(
                    14,
                    color: isUnread
                        ? Colors.white.withValues(alpha: 0.8)
                        : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
