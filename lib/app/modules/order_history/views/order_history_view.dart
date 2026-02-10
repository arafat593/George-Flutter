import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../data/app_text_styles.dart';
import '../controllers/order_history_controller.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF9F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              SizedBox(width: 16.w),
              Icon(
                Icons.arrow_back_ios,
                size: 20.r,
                color: const Color(0xFF6D4C41),
              ),
              Text(
                'Back',
                style: AppTextStyles.semiBold(
                  20,
                  color: const Color(0xFF6D4C41),
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 100.w,
        title: Text(
          "Order History",
          style: AppTextStyles.bold(
            28,
          ).copyWith(color: const Color(0xFF6D4C41)),
        ),
        centerTitle: true,
      ),
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
        border: Border.all(color: const Color(0xFF6D4C41).withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          // Order Image
          Container(
            width: 80.r,
            height: 80.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: NetworkImage(order['image']),
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
                  style: AppTextStyles.regular(
                    12,
                  ).copyWith(color: const Color(0xFF6D4C41).withValues(alpha: 0.6)),
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
