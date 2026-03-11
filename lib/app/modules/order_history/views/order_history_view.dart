import 'package:flutter/material.dart';
import '../../../data/app_colors.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/custom_appbar.dart';
import 'package:get/get.dart';

import '../../../data/app_text_styles.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: 'Order History'),
      body: Obx(
        () => ListView.separated(
          padding: EdgeInsets.all(20.r),
          itemCount: controller.orderHistory.length,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final order = controller.orderHistory[index];
            return _buildOrderCard(order);
          },
        ),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final statusColor = order['status'] == 'Delivered'
        ? Colors.green
        : order['status'] == 'Cancelled'
        ? Colors.red
        : Colors.orange;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6D4C41).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF6D4C41).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          // Order Image
          SizedBox(
            width: 80.r,
            height: 80.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: AppImage(
                url: order['image'] ?? '',
                path: "assets/images/network_placeholder_image.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          // Order Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['orderId'],
                      style: AppTextStyles.bold(
                        16,
                      ).copyWith(color: const Color(0xFF6D4C41)),
                    ),
                    Text(
                      order['amount'],
                      style: AppTextStyles.bold(
                        16,
                      ).copyWith(color: const Color(0xFF6D4C41)),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  order['items'],
                  style: AppTextStyles.regular(12).copyWith(
                    color: const Color(0xFF6D4C41).withValues(alpha: 0.6),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['date'],
                      style: AppTextStyles.medium(12).copyWith(
                        color: const Color(0xFF6D4C41).withValues(alpha: 0.6),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        order['status'],
                        style: AppTextStyles.bold(
                          10,
                        ).copyWith(color: statusColor),
                      ),
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
