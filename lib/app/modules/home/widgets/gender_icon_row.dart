import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/utils/app_size.dart';

class GenderIconsRow extends StatelessWidget {
  const GenderIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.male, size: 20.r, color: AppColors.headlineColor),
        Icon(Icons.female, size: 20.r, color: AppColors.headlineColor),
      ],
    );
  }
}