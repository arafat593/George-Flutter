import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../data/app_colors.dart';
import '../../../../data/app_text_styles.dart';
import '../../../../data/image_path.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 0.75.sh, // Take up 75% of screen height
            child: Image.asset(
              ImagePath.onboardingImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(Icons.image, size: 50.sp, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 0.35.sh, // Overlap slightly or take bottom 35%
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Join Us',
                      style:
                          AppTextStyles.medium(
                            32,
                            color: AppColors.headlineColor,
                            fontFamily:
                                'AppFont', // Assuming general serif or custom font, utilizing TextStyle fallback if needed
                          ).copyWith(
                            fontFamily: 'Times New Roman',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 30.h),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.LOG_IN);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Sign In',
                          style: AppTextStyles.medium(
                            16,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTRATION);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonSecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Create Account',
                          style: AppTextStyles.medium(
                            16,
                            color: AppColors.headlineColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
