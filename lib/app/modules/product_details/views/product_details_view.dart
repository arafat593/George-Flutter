import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Obx(() {
        final product = controller.productDetails.value;
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (product == null) {
          return const Center(child: Text("Product not found"));
        }

        return Stack(
          children: [
            // Top Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 0.5.sh,
              child: Image.network(product.thumbnail, fit: BoxFit.cover),
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
                      color: AppColors.bodyTextColor,
                      size: 18.sp,
                    ),
                    SizedBox(width: 4.w),
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

            // Content Overlay
            Positioned.fill(
              top: 0.45.sh,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 25.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnails
                      if (product.images.isNotEmpty)
                        SizedBox(
                          height: 100.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: product.images.length > 3
                                ? 3
                                : product.images.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              return Container(
                                width: 104.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  product.images[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 25.h),

                      // Material
                      _buildInfoSection("Material:", product.material),
                      SizedBox(height: 15.h),

                      // Dimensions
                      _buildInfoSection("Dimensions:", product.dimensions),
                      SizedBox(height: 15.h),

                      // Description
                      _buildInfoSection("Description:", product.description),
                      SizedBox(height: 15.h),

                      // Pickup Note
                      _buildInfoSection(
                        "Pickup Note:",
                        "Available at the studio.",
                      ),

                      // Bottom padding for footer
                      SizedBox(height: 100.h),
                    ],
                  ),
                ),
              ),
            ),

            // Footer (Quantity & Buy Now)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 30.h),
                color: AppColors.backgroundColor,
                child: Row(
                  children: [
                    // Quantity Control
                    Row(
                      children: [
                        _buildQuantityBtn(
                          icon: Icons.remove,
                          onTap: controller.decrement,
                        ),
                        SizedBox(width: 25.w),
                        Obx(
                          () => Text(
                            controller.quantity.value.toString(),
                            style: AppTextStyles.bold(24),
                          ),
                        ),
                        SizedBox(width: 25.w),
                        _buildQuantityBtn(
                          icon: Icons.add,
                          onTap: controller.increment,
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Buy Now Button
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50.w,
                          vertical: 15.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Buy Now",
                        style: AppTextStyles.bold(
                          18,
                        ).copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            18,
          ).copyWith(color: AppColors.headlineColor),
        ),
        SizedBox(height: 4.h),
        Text(
          content,
          style: AppTextStyles.regular(
            16,
          ).copyWith(color: AppColors.bodyTextColor),
        ),
      ],
    );
  }

  Widget _buildQuantityBtn({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: AppColors.bodyTextColor, size: 24.sp),
    );
  }
}
