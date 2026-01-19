import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/app_colors.dart';
import '../../../../data/app_text_styles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_text_field.dart';
import '../controllers/create_new_password_controller.dart';

class CreateNewPasswordView extends GetView<CreateNewPasswordController> {
  const CreateNewPasswordView({super.key});
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
                    'Create New Password',
                    style: AppTextStyles.bold(
                      32,
                      color: AppColors.headlineColor,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // Description
                Center(
                  child: Text(
                    'Type and confirm a secure new password for your amount,',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular(
                      14,
                      color: AppColors.headlineColor.withOpacity(0.8),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                // Password Label
                Text(
                  'Password',
                  style: AppTextStyles.medium(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
                SizedBox(height: 8.h),
                // Password Field
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: '**** **** ****',
                    obscureText: !controller.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.headlineColor,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                // Confirm Password Label
                Text(
                  'Confirm Password',
                  style: AppTextStyles.medium(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
                SizedBox(height: 8.h),
                // Confirm Password Field
                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    hintText: '**** **** ****',
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColors.headlineColor,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm password';
                      }
                      if (value != controller.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
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
                              // Success logic - probably navigate to login
                              Get.offAllNamed(Routes.LOG_IN);
                              Get.snackbar(
                                'Success',
                                'Password updated successfully',
                                backgroundColor: Colors.green.withOpacity(0.7),
                                colorText: Colors.white,
                              );
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
                            'Save',
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
