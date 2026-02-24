import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/app_text_styles.dart';
import 'package:george/app/modules/auth/recovery_otp/controllers/recovery_otp_controller.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({super.key, required this.isRegistering});
  final bool isRegistering;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RecoveryOtpController>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: PinCodeTextField(
            appContext: context,
            length: 4,
            controller: controller.otpController,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 300),

            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12.r),
              fieldHeight: 56.h,
              fieldWidth: 56.w,
              borderWidth: 1.0,
              activeColor: AppColors.borderColor,
              inactiveColor: AppColors.borderColor,
              selectedColor: AppColors.borderColor,
              activeFillColor: Colors.transparent,
              inactiveFillColor: Colors.transparent,
              selectedFillColor: Colors.transparent,
            ),

            enableActiveFill: false,
            backgroundColor: Colors.transparent,

            textStyle: AppTextStyles.medium(24, color: AppColors.headlineColor),

            onCompleted: (value) {
              appLog("OTP: $value");
            },
            onChanged: (value) {},
          ),
        ),
        SizedBox(height: 40.h),

        // Buttons
        Row(
          children: [
            Expanded(
              child: CustomElevetedButton(
                buttonText: 'Back',
                buttonTextColor: AppColors.headlineColor,
                backgroundColor: AppColors.buttonSecondaryColor,
                onTap: () => Get.back(),
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: CustomElevetedButton(
                buttonText: 'Confirm',
                backgroundColor: AppColors.buttonPrimaryColor,
                buttonTextColor: AppColors.whiteColor,
                onTap: () {
                  if (isRegistering) {
                    return Get.offAllNamed(Routes.customBottomNav);
                  } else {
                    return Get.toNamed(Routes.createNewPassword);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
