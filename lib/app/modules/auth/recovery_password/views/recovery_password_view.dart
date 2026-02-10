import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../../data/app_colors.dart';
import '../../../../data/app_text_styles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_text_field.dart';
import '../controllers/recovery_password_controller.dart';

class RecoveryPasswordView extends GetView<RecoveryPasswordController> {
  const RecoveryPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50.h),
                // Title
                Center(
                  child: Text(
                    'Recover Password',
                    style: AppTextStyles.bold(
                      32,
                      color: AppColors.headlineColor,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Description
                Text(
                  'Enter the Email Address that you used when register to recover your password, You will receive a Verification code.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular(
                    14,
                    color: AppColors.headlineColor.withOpacity(0.8),
                  ),
                ),
                SizedBox(height: 40.h),
                // Email Label
                Text(
                  'Email',
                  style: AppTextStyles.medium(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
                SizedBox(height: 8.h),
                // Email Field
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'example@gmail.com',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 50.h),
                // Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonSecondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Back',
                            style: AppTextStyles.medium(
                              16,
                              color: AppColors.headlineColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.formKey.currentState!.validate()) {
                              Get.toNamed(Routes.RECOVERY_OTP);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonPrimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Next',
                            style: AppTextStyles.medium(
                              16,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
