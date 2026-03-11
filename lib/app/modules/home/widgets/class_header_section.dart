import 'package:flutter/material.dart';
import '../../../data/app_colors.dart';
import '../../../utils/app_size.dart';
import 'package:get/get.dart';

import '../../../data/app_text_styles.dart';
import '../controllers/home_controller.dart';

class ClassHeaderSection extends GetView<HomeController> {
  const ClassHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              controller.selectedDateLabel == 'Upcoming Classes'
                  ? 'Upcoming Classes'
                  : "${controller.selectedDateLabel}'s Classes",
              style: AppTextStyles.bold(24, color: AppColors.headlineColor),
            ),
          ),
          Obx(
            () => Text(
              controller.selectedDateString,
              style: AppTextStyles.regular(14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
