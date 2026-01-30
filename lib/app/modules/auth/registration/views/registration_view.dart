import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/app_colors.dart';
import '../../../../data/app_text_styles.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/custom_text_field.dart';
import '../controllers/registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: RichText(
        text: TextSpan(
          text: label,
          style: AppTextStyles.medium(14, color: AppColors.headlineColor),
          children: [
            TextSpan(
              text: '*',
              style: AppTextStyles.medium(14, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

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
                  'Create Your Account',
                  style: AppTextStyles.bold(
                    32,
                    color: AppColors.headlineColor,
                    fontFamily: 'Times New Roman',
                  ),
                ),
                SizedBox(height: 30.h),

                // Name Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('First name'),
                          CustomTextField(
                            controller: controller.firstNameController,
                            hintText: 'First name',
                            validator: (v) =>
                                v?.isEmpty ?? true ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Last name'),
                          CustomTextField(
                            controller: controller.lastNameController,
                            hintText: 'Last name',
                            validator: (v) =>
                                v?.isEmpty ?? true ? 'Required' : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Phone Number
                _buildLabel('Phone Number'),
                CustomTextField(
                  controller: controller.phoneController,
                  hintText: 'phone number',
                  keyboardType: TextInputType.phone,
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                ),
                SizedBox(height: 20.h),

                // Email
                _buildLabel('Email'),
                CustomTextField(
                  controller: controller.emailController,
                  hintText: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Required';
                    if (!GetUtils.isEmail(v!)) return 'Invalid email';
                    return null;
                  },
                ),
                SizedBox(height: 20.h),

                // Gender
                _buildLabel('Gender'),
                Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.selectedGender.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.buttonSecondaryColor.withOpacity(
                        0.3,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                    ),
                    dropdownColor: AppColors.backgroundColor,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.headlineColor,
                    ),
                    items: ['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: AppTextStyles.regular(
                            14,
                            color: AppColors.headlineColor,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: controller.setGender,
                  ),
                ),
                SizedBox(height: 20.h),

                // Password
                _buildLabel('Password'),
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    hintText: '**** ****',
                    obscureText: !controller.isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (v) =>
                        (v?.length ?? 0) < 6 ? 'Min 6 chars' : null,
                  ),
                ),
                SizedBox(height: 20.h),

                // Confirm Password
                _buildLabel('Confirm Password'),
                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    hintText: '**** ****',
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    validator: (v) => v != controller.passwordController.text
                        ? 'Passwords do not match'
                        : null,
                  ),
                ),
                SizedBox(height: 30.h),

                // Terms and Conditions Checkbox
                Obx(
                  () => Row(
                    children: [
                      Checkbox(
                        value: controller.isTermsAccepted.value,
                        onChanged: (v) =>
                            controller.isTermsAccepted.value = v ?? false,
                        activeColor: AppColors.buttonPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.TERMS_CONDITIONS),
                        child: Text(
                          'I agree to the Terms & Conditions',
                          style: AppTextStyles.regular(
                            14,
                            color: AppColors.headlineColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                // Register Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: controller.isTermsAccepted.value
                          ? () {
                              if (controller.formKey.currentState?.validate() ??
                                  false) {
                                Get.toNamed(Routes.REGISTRATION_OTP);
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.isTermsAccepted.value
                            ? AppColors.buttonPrimaryColor
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Register',
                        style: AppTextStyles.medium(
                          16,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Footer
                Center(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: AppTextStyles.regular(16, color: Colors.grey),
                        children: [
                          TextSpan(
                            text: 'Log in',
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
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
