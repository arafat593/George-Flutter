import 'package:flutter/material.dart';
import 'package:george/app/data/app_text_styles.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../data/app_colors.dart';

class CustomElevetedButton extends StatelessWidget {
  const CustomElevetedButton({
    super.key,
    required this.buttonText,
    this.buttonTextColor = AppColors.whiteColor,
    this.onTap,
    this.backgroundColor = AppColors.buttonPrimaryColor,
  });

  final String buttonText;
  final Color? buttonTextColor, backgroundColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          buttonText,
          style: AppTextStyles.medium(16, color: buttonTextColor),
        ),
      ),
    );
  }
}
