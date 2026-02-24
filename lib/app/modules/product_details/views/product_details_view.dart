import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/product_details_controller.dart';
import '../../../routes/app_pages.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();

    final productName = controller.productArgs['name'] ?? "Yoga Product";
    final productPrice = controller.productArgs['price'] ?? "QAR 2,450";

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.5.sh,
            child: Obx(
              () => Image.network(
                controller.selectedImage.value,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios, color: AppColors.bodyTextColor, size: 18.sp),
                  Text(
                    "Back",
                    style: AppTextStyles.bold(
                      16,
                    ).copyWith(color: AppColors.bodyTextColor),
                  ),
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.55,
            maxChildSize: 0.95,
            snap: true,
            snapSizes: const [0.6, 0.95],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        margin: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                        children: [
                          SizedBox(
                            height: 80.h,
                            child: Row(
                              children: [
                                _buildThumbnail(
                                  controller,
                                  controller.images[0],
                                ),
                                SizedBox(width: 10.w),
                                _buildThumbnail(
                                  controller,
                                  controller.images[1],
                                ),
                                SizedBox(width: 10.w),
                                _buildThumbnail(
                                  controller,
                                  controller.images[2],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          _buildInfoSection(
                            "Material:",
                            "High-density EVA foam",
                          ),
                          SizedBox(height: 15.h),
                          _buildInfoSection(
                            "Dimensions:",
                            "23 cm × 15 cm × 7.5 cm",
                          ),
                          SizedBox(height: 15.h),
                          _buildInfoSection(
                            "Description:",
                            "Perfect for beginners and advanced practitioners. Helps with balance, alignment, and flexibility. Lightweight yet sturdy support for all types of yoga poses. " *
                                4,
                          ),
                          SizedBox(height: 15.h),
                          _buildInfoSection(
                            "Pickup Note:",
                            "Available at the studio.",
                          ),

                          if (controller.productArgs['isOutOfStock'] ==
                              true) ...[
                            SizedBox(height: 20.h),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.red.shade200,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.red.shade700,
                                    size: 20.r,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Out of stock",
                                    style: AppTextStyles.bold(
                                      14,
                                    ).copyWith(color: Colors.red.shade700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          if (controller.productArgs['isOutOfStock'] != true)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _buildQuantitySelector(controller),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(
                          Routes.checkout,
                          arguments: {
                            'name': productName,
                            'price': productPrice,
                            'isFromShop': true,
                          },
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6D4C41),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          elevation: 0,
                        ),
                        child: Text(
                          "Buy Now",
                          style: AppTextStyles.bold(
                            16,
                          ).copyWith(color: Colors.white),
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

  Widget _buildThumbnail(ProductDetailsController controller, String imageUrl) {
    return GestureDetector(
      onTap: () => controller.updateImage(imageUrl),
      child: Obx(() {
        final isSelected = controller.selectedImage.value == imageUrl;
        return Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.headlineColor : Colors.transparent,
              width: 2,
            ),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bold(
            16,
          ).copyWith(color: const Color(0xFF6D4C41)),
        ),
        SizedBox(height: 5.h),
        Text(
          content,
          style: AppTextStyles.regular(14).copyWith(
            color: const Color(0xFF6D4C41).withValues(alpha: 0.8),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector(ProductDetailsController controller) {
    return Row(
      children: [
        Obx(() {
          final isAtMin = controller.count.value <= 1;
          return GestureDetector(
            onTap: controller.decrement,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                "-",
                style: AppTextStyles.medium(24).copyWith(
                  color: isAtMin
                      ? const Color(0xFF6D4C41).withValues(alpha: 0.3)
                      : const Color(0xFF6D4C41),
                ),
              ),
            ),
          );
        }),
        SizedBox(width: 10.w),
        Obx(
          () => Text(
            "${controller.count.value}",
            style: AppTextStyles.bold(
              20,
            ).copyWith(color: const Color(0xFF6D4C41)),
          ),
        ),
        SizedBox(width: 10.w),
        Obx(() {
          final isAtMax = controller.count.value >= controller.availableCount;
          return GestureDetector(
            onTap: controller.increment,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                "+",
                style: AppTextStyles.medium(24).copyWith(
                  color: isAtMax
                      ? const Color(0xFF6D4C41).withValues(alpha: 0.3)
                      : const Color(0xFF6D4C41),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
