import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              SizedBox(width: 16.w),
              Icon(
                Icons.arrow_back_ios,
                size: 20.r,
                color: AppColors.bodyTextColor,
              ),
              Text(
                'Back',
                style: AppTextStyles.semiBold(
                  20,
                  color: AppColors.bodyTextColor,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 100.w,
        title: Text("Terms & Conditions", style: AppTextStyles.bold(28)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              "Introduction",
              "By using this Yoga & Wellness App, you agree to follow and be bound by these Terms and Conditions. These terms apply to all users including members, instructors, and service providers.",
            ),
            _buildSection(
              "Eligibility",
              "You must be at least 18 years old or have permission from a parent or legal guardian to use this app.",
            ),
            _buildSection(
              "Health Disclaimer",
              "This app provides yoga, meditation, fitness, and wellness content for general informational purposes only.\nIt is not a substitute for medical advice, diagnosis, or treatment.\nAlways consult a doctor before starting any new exercise or wellness program.",
            ),
            _buildSection(
              "User Responsibility",
              "You are responsible for your own health and safety while using the app.\nThe app and its instructors are not liable for any injury, discomfort, or health issues that may occur.",
            ),
            _buildSection(
              "Account Usage",
              "You are responsible for maintaining the confidentiality of your account.\nYou must provide accurate information when creating your profile.",
            ),
            _buildSection(
              "Subscriptions & Payments",
              "Some features may require payment or a subscription.\nAll payments are non-refundable unless stated otherwise.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bold(
              18,
            ).copyWith(color: AppColors.headlineColor),
          ),
          SizedBox(height: 10.h),
          Text(
            content,
            style: AppTextStyles.regular(14).copyWith(
              color: AppColors.bodyTextColor.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
