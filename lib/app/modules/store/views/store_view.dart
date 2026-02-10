import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/store_controller.dart';

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(() {
            return GridView.builder(
              padding: EdgeInsets.only(bottom: 80.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70, // Adjusted for image + text height
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 20.h,
              ),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];
                return _buildProductCard(product);
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.PRODUCT_DETAILS, arguments: product),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.grey[300],
                    image: DecorationImage(
                      image: NetworkImage(product['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: product['isOutOfStock']
                          ? Colors.black.withValues(alpha: 0.7)
                          : const Color(
                              0xFF6D4C41,
                            ).withValues(alpha: 0.8), // Dark brown/transparent
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      product['isOutOfStock']
                          ? "Out of stock"
                          : "Available ${product['available']}",
                      style: AppTextStyles.medium(
                        10,
                      ).copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            product['name'],
            style: AppTextStyles.medium(
              14,
            ).copyWith(color: const Color(0xFF6D4C41), height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.h),
          Text(
            product['price'],
            style: AppTextStyles.bold(
              16,
            ).copyWith(color: const Color(0xFF4E342E)),
          ),
        ],
      ),
    );
  }
}
