import 'package:flutter/material.dart';
import '../../../data/app_colors.dart';
import '../../../data/image_path.dart';
import '../controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/custom_text_button.dart';
import '../../../widgets/rounded_icon_container.dart';
import 'package:get/get.dart';

import '../../../widgets/snack_bar/app_snack_bar.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomTextButton(
            icon: Icons.menu_book,
            buttonText: 'Bookings',
            onTap: () {
              // Get.toNamed(Routes.myBookings);
              AppSnackBar.success('Wating for payment implementation');
            },
          ),
          Image.asset(
            ImagePath.splashImage,
            height: 100.h,
            width: 100.w,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              RoundedIconContainer(
                iconPath: ImagePath.funnelIcon,
                onTap: () {
                  // filterController.resetTemp();
                  Get.toNamed(
                    Routes.filter,
                    arguments: {
                      'instructors': controller.allInstructor.value,
                      'classes': controller.allClassName.value,
                    },
                  );
                },
                backgroundColor:
                    //  isFilterActive
                    //     ? AppColors.buttonPrimaryColor
                    //     :
                    Colors.white,
                iconColor:
                    // isFilterActive
                    //     ? Colors.white
                    //     :
                    AppColors.headlineColor,
                // border: isFilterActive
                //     ? Border.all(color: AppColors.headlineColor, width: 2.r)
                //     : null,
              ),
              SizedBox(width: 12.w),
              RoundedIconContainer(
                iconPath: ImagePath.notification,
                onTap: () {
                  return Get.toNamed(Routes.notifications);
                  // AppSnackBar.success('Wating for payment implementation');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
