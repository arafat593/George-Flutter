import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../../models/store_product_model.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/store_controller.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Obx(() {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (controller.products.isEmpty) {
              return Center(child: Text("No data found"));
            }
            return GridView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
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

  Widget _buildProductCard(StoreProductModel product) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.productDetails, arguments: product.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: AppSize.size.height * 0.5,
                  width: AppSize.size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.grey[300],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox(
                          child: Image.network(
                            "https://as1.ftcdn.net/jpg/10/22/24/80/1000_F_1022248039_7LDxHRi3Mlt9BK3wzLBUGZp9XAO1gt2s.jpg",
                            fit: BoxFit.cover,
                          ),
                        );
                      },
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
                      color: product.stockQuantity == 0
                          ? Colors.black.withValues(alpha: 0.7)
                          : const Color(
                              0xFF6D4C41,
                            ).withValues(alpha: 0.8), // Dark brown/transparent
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      product.stockQuantity == 0
                          ? "Out of stock"
                          : "Available ${product.stockQuantity}",
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
            product.name,
            style: AppTextStyles.medium(
              14,
            ).copyWith(color: const Color(0xFF6D4C41), height: 1.2),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 5.h),
          Text(
            "${product.price}",
            style: AppTextStyles.bold(
              16,
            ).copyWith(color: const Color(0xFF4E342E)),
          ),
        ],
      ),
    );
  }
}
