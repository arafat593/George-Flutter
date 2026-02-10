import 'package:flutter/material.dart';

import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../../data/app_colors.dart';
import '../../../../data/app_text_styles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_text_field.dart';
import '../controllers/log_in_controller.dart';

class LogInView extends GetView<LogInController> {
  const LogInView({super.key});
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
                Text(
                  'Welcome Back to\nInara Yoga',
                  style: AppTextStyles.bold(
                    32,
                    color: AppColors.headlineColor,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Email or Phone number',
                  style: AppTextStyles.medium(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
                SizedBox(height: 8.h),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'enter your email or phone number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'Password',
                  style: AppTextStyles.medium(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    obscureText: !controller.isPasswordVisible.value,
                    hintText: '**** **** ****',
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
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: Checkbox(
                          value: controller.isRememberMe.value,
                          onChanged: (value) => controller.toggleRememberMe(),
                          activeColor: AppColors.buttonPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          side: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Remember me',
                      style: AppTextStyles.regular(
                        14,
                        color: AppColors.headlineColor,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.RECOVERY_PASSWORD);
                      },
                      child: Text(
                        'Forgot password',
                        style: AppTextStyles.medium(
                          14,
                          color: AppColors.errorColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Log In',
                      style: AppTextStyles.medium(
                        16,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.REGISTRATION);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyles.regular(16, color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: AppTextStyles.bold(
                              16,
                              color: AppColors.headlineColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
