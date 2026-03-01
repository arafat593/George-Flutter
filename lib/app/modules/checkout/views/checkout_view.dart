import 'dart:math';

import 'package:flutter/material.dart';
import 'package:george/app/modules/store/controllers/store_controller.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../../product_details/controllers/product_details_controller.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  CheckoutView({super.key});

  final storeController = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: AppTextStyles.bold(28, color: AppColors.headlineColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: AppColors.headlineColor,
              ),
              Text(
                "Back",
                style: AppTextStyles.semiBold(
                  20,
                  color: AppColors.headlineColor,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Name
            Obx(
              () => controller.itemName.value.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        controller.itemName.value,
                        style: const TextStyle(
                          color: Color(0xFF5D4037),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
            // Total Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.headlineColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Quantity :${controller.product.quantity}",
                        style: TextStyle(
                          color: AppColors.headlineColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Price QAR :${controller.product.price}",
                        style: TextStyle(
                          color: AppColors.headlineColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total Price",
                        style: TextStyle(
                          color: AppColors.headlineColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "QAR ${controller.product.totalPrice}",
                        style: TextStyle(
                          color: AppColors.headlineColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            const Text(
              "Payment Method",
              style: TextStyle(
                color: AppColors.headlineColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            // Payment Methods List
            _buildPaymentMethods(),

            // Conditional Credit/Debit Form
            Obx(
              () => controller.selectedPaymentMethod.value == 3
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: _buildCreditDebitForm(),
                    )
                  : const SizedBox(),
            ),

            const SizedBox(height: 20),

            // Pay Now Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  // Show loading dialog to simulate "process to payment"
                  Get.dialog(
                    const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff5D4037),
                      ),
                    ),
                    barrierDismissible: false,
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    Get.back(); // close dialog
                    Get.toNamed(
                      Routes.bookingConfirmed,
                      arguments: {
                        'message': controller.fromMembership.value
                            ? '${controller.itemName.value} Confirmed!'
                            : controller.isFromShop.value
                            ? 'Order Confirmed!'
                            : 'Payment Confirmed!',
                      },
                      preventDuplicates: false,
                    );
                  });
                },
                child: const Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Suggested Section
            Obx(
              () => controller.shouldHideSuggestions.value
                  ? const SizedBox()
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Suggested For you",
                            style: AppTextStyles.bold(
                              24,
                              color: const Color(0xFF5D4037),
                            ),
                          ),
                          const SizedBox(height: 15),
                          _buildSuggestedList(),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final methods = [
      {
        'title': 'Wallet',
        'subtitle': 'Balance QAR 1000',
        'icon': Icons.account_balance_wallet_outlined,
      },
      {'title': 'Apple pay', 'icon': Icons.apple},
      {'title': 'Google pay', 'icon': Icons.g_mobiledata},
      {'title': 'Credit/Debit', 'icon': Icons.credit_card},
    ];

    return Obx(() {
      return Column(
        children: List.generate(methods.length, (index) {
          final isSelected = controller.selectedPaymentMethod.value == index;
          final method = methods[index];

          return GestureDetector(
            onTap: () => controller.selectPaymentMethod(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF6D4C41),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      method['icon'] as IconData,
                      color: const Color(0xFF5D4037),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          method['title'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (method.containsKey('subtitle')) ...[
                          const SizedBox(height: 2),
                          Text(
                            method['subtitle'] as String,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Radio Button Style
                  Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: isSelected
                        ? Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        }),
      );
    });
  }

  Widget _buildCreditDebitForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffEBE3D9), // Light beige background
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Credit/Debit" Label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF5D4037), // Dark brown matches design
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.credit_card, color: Colors.white, size: 22),
                SizedBox(width: 8),
                Text(
                  "Credit/Debit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Name Fields
          Row(
            children: [
              Expanded(
                child: _buildTextField("First Name", controller.firstNameCtrl),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildTextField("Last Name", controller.lastNameCtrl),
              ),
            ],
          ),
          const SizedBox(height: 15),

          _buildTextField("Routing Number", controller.routingNumberCtrl),
          const SizedBox(height: 15),
          _buildTextField("Account Number", controller.accountNumberCtrl),
          const SizedBox(height: 15),
          _buildTextField(
            "Verify Account Number",
            controller.verifyAccountNumberCtrl,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xFFBCAAA4).withValues(alpha: 0.6),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: const Color(0xFF5D4037).withValues(alpha: 0.5),
            fontSize: 15,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        style: const TextStyle(color: Color(0xFF5D4037), fontSize: 16),
      ),
    );
  }

  Widget _buildSuggestedList() {
    return Obx(() {
      if (controller.isFromShop.value) {
        return _buildSuggestedProductsGrid();
      } else {
        return _buildSuggestedMembershipsList();
      }
    });
  }

  Widget _buildSuggestedMembershipsList() {
    return Column(
      children: List.generate(controller.suggestedMemberships.length, (index) {
        final item = controller.suggestedMemberships[index];
        final title = item['title'];
        final price = item['price'];
        final validity = item['validity'];
        final autoRenew = item['autoRenew'] as bool;

        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFFEBE3D9)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.headlineColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      color: AppColors.headlineColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: AppColors.headlineColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    validity,
                    style: TextStyle(
                      color: AppColors.headlineColor,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(
                          Routes.memberships,
                          arguments: {'isFromSuggestions': true},
                        );
                      },
                      child: const Text(
                        "Buy",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: autoRenew,
                      onChanged: (val) => controller.toggleAutoRenew(index),
                      activeThumbColor: AppColors.buttonPrimaryColor,
                    ),
                  ),
                  Text(
                    "Auto Renew",
                    style: TextStyle(
                      color: AppColors.headlineColor.withValues(alpha: 0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildSuggestedProductsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: min(4, storeController.products.length),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        final products = storeController.products.value[index];
        return InkWell(
          onTap: () {
            Get.back(result: products.id);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: AppSize.size.height * 0.5,
                  width: AppSize.size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      products.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          "https://as1.ftcdn.net/jpg/10/22/24/80/1000_F_1022248039_7LDxHRi3Mlt9BK3wzLBUGZp9XAO1gt2s.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                products.name,
                style: TextStyle(
                  color: AppColors.headlineColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                "${products.price}",
                style: TextStyle(
                  color: AppColors.headlineColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
