import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/app_text_styles.dart';
import 'package:george/app/modules/home/widgets/available_spot_indicator.dart';
import 'package:george/app/modules/home/widgets/badge_container.dart';
import 'package:george/app/modules/home/widgets/cancelled_indicator.dart';
import 'package:george/app/modules/home/widgets/fully_booked_indicator.dart';
import 'package:george/app/modules/home/widgets/gender_icon_row.dart';
import 'package:george/app/modules/home/widgets/wait_list_dialog.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

class ClassCard extends StatelessWidget {
  final String badge;
  final String title;
  final String price;
  final String time;
  final String instructor;
  final String status;
  final int? availableSeats;
  final bool isMembershipPaid;
  final String image;
  final double progress;
  final String classId;
  final String gender;

  const ClassCard({
    super.key,
    required this.badge,
    required this.title,
    required this.price,
    required this.time,
    required this.instructor,
    required this.status,
    this.availableSeats,
    required this.isMembershipPaid,
    required this.image,
    required this.progress,
    required this.classId,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    final classStatus = status.toLowerCase();
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.courseDetails, arguments: classId);
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(color: AppColors.cardBackgroundColor, borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BadgeContainer(text: badge),
                    if (isMembershipPaid) ...[SizedBox(width: 8.w), BadgeContainer(text: 'Membership')],
                  ],
                ),
                Text(price, style: AppTextStyles.bold(20, color: AppColors.headlineColor)),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(title, style: AppTextStyles.medium(18, color: AppColors.headlineColor)),
                ),
                GenderIconsRow(gender: gender),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 15.r, backgroundImage: NetworkImage(image)),
                    SizedBox(width: 8.w),
                    Text(instructor, style: AppTextStyles.regular(14, color: AppColors.headlineColor)),
                  ],
                ),
                const Spacer(),
                if (status == 'available')
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        Routes.courseDetails,
                        preventDuplicates: true,
                        arguments: {'title': title, 'price': price, 'fromHistory': status != 'available'},
                      );
                    },
                    child: Icon(Icons.arrow_forward, color: AppColors.headlineColor, size: 24.r),
                  )
                else if (status == 'fully_booked')
                  GestureDetector(
                    onTap: () => waitListDialog(context: context),
                    child: Icon(Icons.notification_add_outlined, color: AppColors.headlineColor, size: 24.r),
                  ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16.r, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(time, style: AppTextStyles.regular(14, color: Colors.grey)),
                  ],
                ),
                if (classStatus != 'cancelled' && availableSeats != 0)
                  SizedBox(
                    width: 100.w,
                    child: AvailableSpotsIndicator(availableSeats: availableSeats ?? 0, progress: progress),
                  )
                else if (availableSeats == 0)
                  const FullyBookedIndicator()
                else if (classStatus == 'cancelled')
                  const CancelledIndicator(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
