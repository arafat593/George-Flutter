import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../widgets/app_image/app_image.dart';
import '../controllers/course_instructor_details_controller.dart';
import '../widgets/course_upcoming_classes.dart';

class CourseInstructorDetailsView
    extends GetView<CourseInstructorDetailsController> {
  const CourseInstructorDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        final instructor = controller.instructorDeatils.value;
        final backgroundImage = instructor?.backgroundImage;
        final speciality = instructor?.speciality ?? 'No Specilaity Added';
        final instructorName = instructor?.name ?? 'No Instructor Name added';
        final bio = instructor?.bio ?? 'No bio added yet.';
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 450.h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AppImage(
                    url: backgroundImage,
                    path: "assets/images/network_placeholder_image.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 450.h,
                  ),

                  /// Dark overlay
                  Container(color: Colors.black.withValues(alpha: 0.4)),
                ],
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.55,
              maxChildSize: 0.85,
              snap: true,
              snapSizes: const [0.6, 0.85],
              builder: (context, scrollController) => Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ListView(
                    controller: scrollController,
                    shrinkWrap: true,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              instructorName,
                              style: AppTextStyles.bold(
                                24,
                                color: const Color(0xFF6B5345),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3EFE9),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: const Color(0xFFBCB1AA),
                              ),
                            ),
                            child: Text(
                              speciality,
                              style: AppTextStyles.medium(
                                10,
                                color: const Color(0xFF6B5345),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Bio',
                        style: AppTextStyles.bold(
                          20,
                          color: const Color(0xFF6B5345),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        bio,
                        style: AppTextStyles.regular(
                          14,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Text(
                        'Upcoming Classes',
                        style: AppTextStyles.bold(
                          20,
                          color: const Color(0xFF6B5345),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CourseUpcomingClassesCard(instructor: instructor),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50.h,
              left: 20.w,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.bodyTextColor,
                      size: 18.r,
                    ),
                    Text(
                      'Back',
                      style: AppTextStyles.bold(
                        16,
                        color: AppColors.bodyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
