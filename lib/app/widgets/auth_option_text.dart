import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/app_text_styles.dart';

class AuthOptions extends StatelessWidget {
  const AuthOptions({
    super.key,
    this.onTap,
    required this.titleText,
    required this.optionText,
  });
  final Function()? onTap;
  final String titleText, optionText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: RichText(
          text: TextSpan(
            text: titleText,
            style: AppTextStyles.regular(16, color: Colors.grey),
            children: [
              TextSpan(
                text: optionText,
                style: AppTextStyles.bold(16, color: AppColors.headlineColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}