import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    // Use the image passed from previous screen if available, otherwise fallback
    final heroImage = controller.productArgs['image'] ?? controller.images[0];
    final productName = controller.productArgs['name'] ?? "Yoga Product";
    final productPrice = controller.productArgs['price'] ?? "QAR 2,450";

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          // Background Image (Top Half)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.5.sh, // Take up half the screen height initially
            child: Image.network(heroImage, fit: BoxFit.cover),
          ),

          // Back Button
          Positioned(
            top: 50.h,
            left: 20.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: const Color(0xFF6D4C41),
                    size: 18.sp,
                  ),
                  Text(
                    "Back",
                    style: AppTextStyles.medium(
                      16,
                    ).copyWith(color: const Color(0xFF6D4C41)),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Sheet Content
          Positioned.fill(
            top: 0.35.sh, // Start slightly before the image ends
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF3EFE9), // Light beige background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Thumbnails
                    SizedBox(
                      height: 80.h,
                      child: Row(
                        children: [
                          _buildThumbnail(controller.images[0]),
                          SizedBox(width: 10.w),
                          _buildThumbnail(controller.images[1]),
                          SizedBox(width: 10.w),
                          _buildThumbnail(controller.images[2]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Title (Implicit in design context, though not explicitly large in screenshot, usually needed)
                            /* Text(
                              productName,
                              style: AppTextStyles.bold(22).copyWith(color: AppColors.headlineColor),
                            ),
                            SizedBox(height: 10.h), */

                            // Info Sections
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
                              "Perfect for beginners and advanced practitioners. Helps with balance, alignment, and flexibility. Lightweight yet sturdy support for all types of yoga poses.",
                            ),
                            SizedBox(height: 15.h),
                            _buildInfoSection(
                              "Pickup Note:",
                              "Available at the studio.",
                            ),

                            // Out of Stock Badge (if applicable)
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
                            SizedBox(height: 30.h),
                          ],
                        ),
                      ),
                    ),

                    // Bottom Action Bar (Quantity + Buy Now) - Only show if in stock
                    if (controller.productArgs['isOutOfStock'] != true)
                      Padding(
                        padding: EdgeInsets.only(bottom: 30.h, top: 10.h),
                        child: Row(
                          children: [
                            // Quantity Selector
                            _buildQuantitySelector(controller),
                            SizedBox(width: 20.w),

                            // Buy Now Button
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Get.toNamed(
                                  Routes.CHECKOUT,
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
                      )
                    else
                      SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThumbnail(String imageUrl) {
    return Container(
      width: 80.w,
      height: 80.w, // Square
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
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
            color: const Color(0xFF6D4C41).withOpacity(0.8),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector(ProductDetailsController controller) {
    return Row(
      children: [
        GestureDetector(
          onTap: controller.decrement,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              "-",
              style: AppTextStyles.medium(
                24,
              ).copyWith(color: const Color(0xFF6D4C41)),
            ),
          ),
        ),
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
        GestureDetector(
          onTap: controller.increment,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              "+",
              style: AppTextStyles.medium(
                24,
              ).copyWith(color: const Color(0xFF6D4C41)),
            ),
          ),
        ),
      ],
    );
  }
}
