import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/app_text_styles.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/custom_appbar.dart';

import 'package:get/get.dart';

import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'FaqView'),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.buttonPrimaryColor,
            ),
          );
        }

        final faq = controller.faq.value;

        if (faq == null || faq.content.isEmpty) {
          return Center(
            child: Text(
              "No FAQ available.",
              style: AppTextStyles.regular(
                14,
              ).copyWith(color: AppColors.bodyTextColor),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Text(
            faq.content,
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
