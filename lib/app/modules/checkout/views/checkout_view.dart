import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            color: AppColors.headlineColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: const [
              SizedBox(width: 16),
              Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: AppColors.headlineColor,
              ),
              Text(
                "Back",
                style: TextStyle(
                  color: AppColors.headlineColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 80,
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
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      color: AppColors.headlineColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.cartTotal.value,
                      style: TextStyle(
                        color: AppColors.headlineColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                  backgroundColor: AppColors.buttonPrimaryColor, // Brown
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                onPressed: () {
                  Get.toNamed(Routes.BOOKING_CONFIRMED);
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Suggested For you",
                    style: TextStyle(
                      color: Color(0xFF5D4037),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildSuggestedList(),
                ],
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
                              color: Colors.white.withOpacity(0.7),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6D4C41), // Dark brown
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.credit_card, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  "Credit/Debit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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
    return SizedBox(
      height: 50,
      child: CustomTextField(controller: controller, hintText: hint),
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
                      onPressed: () {},
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
                      activeColor: AppColors.buttonPrimaryColor,
                    ),
                  ),
                  Text(
                    "Auto Renew",
                    style: TextStyle(
                      color: AppColors.headlineColor.withOpacity(0.8),
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
      itemCount: controller.suggestedProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        final product = controller.suggestedProducts[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(product['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product['name'],
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
              product['price'],
              style: TextStyle(
                color: AppColors.headlineColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
