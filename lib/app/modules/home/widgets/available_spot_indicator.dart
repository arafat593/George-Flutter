import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/app_text_styles.dart';
import 'package:george/app/utils/app_size.dart';

class AvailableSpotsIndicator extends StatelessWidget {
  final int spots;

  const AvailableSpotsIndicator({super.key, required this.spots});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'Available spots $spots',
          style: AppTextStyles.regular(10, color: Colors.grey),
        ),
        SizedBox(height: 4.h),
        Container(
          width: 100.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Stack(
            children: [
              Container(
                width: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.buttonPrimaryColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              Positioned(
                left: 75.w,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 8.r,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}