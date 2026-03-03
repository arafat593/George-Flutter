import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/app_text_styles.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/custom_appbar.dart';

import 'package:get/get.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonPrimaryColor,
            ),
          );
        }

        final privacyPolicy = controller.privacyPolicy.value;

        if (privacyPolicy == null || privacyPolicy.content.isEmpty) {
          return Center(
            child: Text(
              "No Privacy Policy available.",
              style: AppTextStyles.regular(
                14,
              ).copyWith(color: AppColors.bodyTextColor),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Text(
            privacyPolicy.content,
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
