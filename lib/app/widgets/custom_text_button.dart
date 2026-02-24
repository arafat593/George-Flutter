import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/app_text_styles.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.icon,
    required this.buttonText,
    this.textColor = AppColors.headlineColor,
    this.iconColor = AppColors.headlineColor,
  });
  final IconData icon;
  final String buttonText;
  final Color? iconColor, textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Get.toNamed(Routes.myBookings);
      },
      icon: Icon(icon, size: 24.r, color: iconColor),
      label: Text(
        buttonText,
        style: AppTextStyles.medium14.apply(color: textColor),
      ),
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
    );
  }
}