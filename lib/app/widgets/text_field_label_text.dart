import 'package:flutter/material.dart';

import '../data/app_colors.dart';
import '../data/app_text_styles.dart';
import '../utils/app_size.dart';

class TextFieldLabelText extends StatelessWidget {
  const TextFieldLabelText({
    super.key,
    required this.label,
    this.showAstric = true,
  });
  final String label;
  final bool showAstric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: AppTextStyles.medium(14, color: AppColors.headlineColor),
              children: [
                if (showAstric)
                  TextSpan(
                    text: '*',
                    style: AppTextStyles.medium(14, color: Colors.red),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
