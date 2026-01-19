import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../data/app_colors.dart';
import '../../../../data/app_text_styles.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/recovery_otp_controller.dart';

class RecoveryOtpView extends GetView<RecoveryOtpController> {
  const RecoveryOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Text(
                'Verification',
                style: AppTextStyles.bold(
                  32,
                  color: AppColors.headlineColor,
                  fontFamily: 'Times New Roman',
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'We sent Verification code to your Email address',
                textAlign: TextAlign.center,
                style: AppTextStyles.regular(
                  14,
                  color: AppColors.headlineColor.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Field
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

                  textStyle: AppTextStyles.medium(
                    24,
                    color: AppColors.headlineColor,
                  ),

                  onCompleted: (value) {
                    print("OTP: $value");
                  },
                  onChanged: (value) {},
                ),
              ),

              SizedBox(height: 40.h),

              // Buttons
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
                          Get.toNamed(Routes.CREATE_NEW_PASSWORD);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Confirm',
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

              SizedBox(height: 30.h),

              // Resend Text
              GestureDetector(
                onTap: () {
                  controller.startTimer();
                },
                child: RichText(
                  text: TextSpan(
                    text: "Didn't receive a code! ",
                    style: AppTextStyles.regular(14, color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'Resend',
                        style: AppTextStyles.bold(
                          14,
                          color: AppColors.headlineColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // Timer
              Obx(
                () => Text(
                  controller.timerText,
                  style: AppTextStyles.medium(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
