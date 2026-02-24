import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/wallet_controller.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletController());
    // final bool showBackButton =
    //     Get.arguments != null && Get.arguments['fromProfile'] == true;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(child: _buildAppBar()),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBalanceCard(controller),
              SizedBox(height: 25.h),
              Text(
                "Payment Method",
                style: AppTextStyles.bold(
                  18,
                ).copyWith(color: AppColors.headlineColor),
              ),
              SizedBox(height: 15.h),
              _buildPaymentMethods(controller),
              Obx(
                () => controller.selectedPaymentMethod.value == 2
                    ? Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: _buildCreditDebitForm(controller),
                      )
                    : const SizedBox(),
              ),

              SizedBox(height: 25.h),
              Text(
                "Payment History",
                style: AppTextStyles.bold(
                  18,
                ).copyWith(color: AppColors.headlineColor),
              ),
              SizedBox(height: 15.h),
              _buildPaymentHistory(controller),
              SizedBox(height: 70.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Wallet',
            style: AppTextStyles.bold(24, color: AppColors.headlineColor),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditDebitForm(WalletController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xffEBE3D9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF6D4C41),
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

  Widget _buildBalanceCard(WalletController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF6D4C41), // Matching the dark brown in image
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: NetworkImage("https://picsum.photos/seed/pattern/500/500"),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles/wireframe simulation using simple shapes if no image
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 150.r,
              height: 150.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Balance",
                style: AppTextStyles.regular(
                  14,
                ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => Text(
                  "QAR ${controller.balance.value.toStringAsFixed(2)}",
                  style: AppTextStyles.bold(28).copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 36.h,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.topUpSuccess),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6D4C41),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    elevation: 0,
                  ),
                  child: Text(
                    "Add Money",
                    style: AppTextStyles.medium(14).copyWith(
                      color: const Color(0xFF6D4C41),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(WalletController controller) {
    return Column(
      children: [
        _paymentMethodItem(
          controller,
          index: 0,
          label: "Apple pay",
          icon: Icons.apple,
        ),
        SizedBox(height: 12.h),
        _paymentMethodItem(
          controller,
          index: 1,
          label: "Google pay",
          icon: Icons.g_mobiledata, // Best approximation or use custom asset
        ),
        SizedBox(height: 12.h),
        _paymentMethodItem(
          controller,
          index: 2,
          label: "Credit/Debit",
          icon: Icons.credit_card,
        ),
      ],
    );
  }

  Widget _paymentMethodItem(
    WalletController controller, {
    required int index,
    required String label,
    required IconData icon,
  }) {
    return Obx(() {
      final isSelected = controller.selectedPaymentMethod.value == index;
      return GestureDetector(
        onTap: () => controller.selectPaymentMethod(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF6D4C41), // Dark brown background
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.black, size: 24.r),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.medium(16).copyWith(
                    color: const Color(0xFFD7CCC8), // Light beige text
                  ),
                ),
              ),
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD7CCC8), width: 2),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPaymentHistory(WalletController controller) {
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.historyList.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final item = controller.historyList[index];
          final isCredit = item['isCredit'] as bool;
          return Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFFEBE3D9), // Light creamy card color
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isCredit ? Icons.arrow_back : Icons.arrow_outward,
                    color: isCredit ? Colors.green : Colors.red,
                    size: 20.r,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: AppTextStyles.medium(16).copyWith(
                          color: AppColors.headlineColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item['date'],
                        style: AppTextStyles.regular(
                          12,
                        ).copyWith(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Text(
                  item['amount'],
                  style: AppTextStyles.medium(14).copyWith(
                    color: isCredit ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
