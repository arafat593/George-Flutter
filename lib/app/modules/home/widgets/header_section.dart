import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/image_path.dart';
import 'package:george/app/modules/courses/controllers/filter_controller.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/custom_text_button.dart';
import 'package:george/app/widgets/rounded_icon_container.dart';
import 'package:get/get.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(icon: Icons.menu_book, buttonText: 'Bookings'),
          Image.asset(
            ImagePath.splashImage,
            height: 140.h,
            width: 140.w,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              Obx(() {
                final filterController = Get.find<FilterController>();
                final isFilterActive = filterController.isFilterApplied.value;

                return RoundedIconContainer(
                  iconPath: ImagePath.funnelIcon,
                  onTap: () {
                    filterController.resetTemp();
                    Get.toNamed(Routes.filter);
                  },
                  backgroundColor: isFilterActive
                      ? AppColors.buttonPrimaryColor
                      : Colors.white,
                  iconColor: isFilterActive
                      ? Colors.white
                      : AppColors.headlineColor,
                  border: isFilterActive
                      ? Border.all(color: AppColors.headlineColor, width: 2.r)
                      : null,
                );
              }),
              SizedBox(width: 12.w),
              RoundedIconContainer(
                iconPath: ImagePath.notification,
                onTap: () => Get.toNamed(Routes.notifications),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
