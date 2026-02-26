import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/modules/auth/create_new_password/controllers/create_new_password_controller.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/custom_elevated_button.dart';
import 'package:george/app/widgets/custom_text_field.dart';
import 'package:george/app/widgets/text_field_label_text.dart';
import 'package:get/get.dart';

class NewPassForm extends StatelessWidget {
  const NewPassForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateNewPasswordController>();
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldLabelText(label: 'Password'),
          // Password Field
          Obx(
            () => CustomTextField(
              controller: controller.passwordController,
              hintText: '**** **** ****',
              obscureText: !controller.isPasswordVisible.value,
              suffixIcon: IconButton(
                icon: Icon(controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off, color: AppColors.headlineColor),
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
          TextFieldLabelText(label: 'Confirm Password'),
          // Confirm Password Field
          Obx(
            () => CustomTextField(
              controller: controller.confirmPasswordController,
              hintText: '**** **** ****',
              obscureText: !controller.isConfirmPasswordVisible.value,
              suffixIcon: IconButton(
                icon: Icon(controller.isConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off, color: AppColors.headlineColor),
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
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: CustomElevetedButton(
                    buttonText: 'Back',
                    backgroundColor: AppColors.buttonSecondaryColor,
                    buttonTextColor: AppColors.headlineColor,
                    onTap: () => Get.back(),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: CustomElevetedButton(
                    buttonText: controller.isLoading.value ? "loading.." : 'Save',
                    onTap: () {
                      controller.checkAndUpdate();
                      // if (controller.formKey.currentState!.validate()) {
                      //   // Success logic - probably navigate to login
                      //   Get.offAllNamed(Routes.logIn);
                      //   Get.snackbar(
                      //     'Success',
                      //     'Password updated successfully',
                      //     backgroundColor: Colors.green.withValues(
                      //       alpha: 0.7,
                      //     ),
                      //     colorText: Colors.white,
                      //   );
                      // }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
