import 'package:flutter/material.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/custom_appbar.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/terms_conditions_controller.dart';

class TermsConditionsView extends GetView<TermsConditionsController> {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(title: 'Terms & Conditions'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonPrimaryColor,
            ),
          );
        }

        final terms = controller.termsCondition.value;

        if (terms == null || terms.content.isEmpty) {
          return Center(
            child: Text(
              "No Terms & Conditions available.",
              style: AppTextStyles.regular(
                14,
              ).copyWith(color: AppColors.bodyTextColor),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Text(
            terms.content,
            style: AppTextStyles.regular(14).copyWith(
              color: AppColors.bodyTextColor.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        );
      }),
    );
  }
}
