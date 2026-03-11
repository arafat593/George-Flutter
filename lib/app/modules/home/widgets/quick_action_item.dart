import 'package:flutter/material.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../utils/app_size.dart';

class QuickActionItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  const QuickActionItem({
    super.key,
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 50.h,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              iconPath,
              height: 50.h,
              width: 35.h,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: AppTextStyles.regular(12, color: AppColors.headlineColor),
          ),
        ],
      ),
    );
  }
}
