import 'package:flutter/material.dart';
import '../../data/app_colors.dart';
import '../../utils/app_size.dart';
import '../texts/app_text.dart';

import 'package:get/get.dart';

class AppSnackBar {
  static void error(String parameterValue, {SnackPosition? snackPosition}) {
    Get.showSnackbar(
      GetSnackBar(
        isDismissible: true,
        snackPosition: snackPosition ?? SnackPosition.top,
        backgroundColor: AppColors.errorColor.withValues(alpha: 0.9),
        animationDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 5),
        messageText: AppText(data: parameterValue, color: AppColors.whiteColor),
        borderRadius: AppSize.w(5.0),
        padding: EdgeInsets.all(AppSize.w(10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.w(20.0), vertical: AppSize.w(20)),
      ),
    );
  }

  static void success(String parameterValue, {SnackPosition? snackPosition, Duration? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: AppColors.success,
        animationDuration: const Duration(seconds: 2),
        duration: duration ?? const Duration(seconds: 3),
        snackPosition: snackPosition ?? SnackPosition.top,
        messageText: AppText(data: parameterValue, color: AppColors.whiteColor, fontWeight: FontWeight.w500),
        borderRadius: AppSize.w(5.0),
        padding: EdgeInsets.all(AppSize.w(10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.w(20.0), vertical: AppSize.w(20)),
      ),
    );
  }

  static void message(String parameterValue, {Color? backgroundColor, Color? color, SnackPosition? snackPosition}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: backgroundColor ?? AppColors.dark300,
        animationDuration: const Duration(seconds: 2),
        duration: const Duration(seconds: 3),
        snackPosition: snackPosition ?? SnackPosition.top,
        messageText: AppText(data: parameterValue, color: color ?? AppColors.white300, fontSize: 16, fontWeight: FontWeight.w400),
        borderRadius: AppSize.w(5.0),
        padding: EdgeInsets.all(AppSize.w(10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.w(20.0), vertical: AppSize.w(20)),
      ),
    );
  }
}
