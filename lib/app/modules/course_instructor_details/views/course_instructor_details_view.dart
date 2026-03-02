import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/course_instructor_details_controller.dart';
import '../widgets/upcoming_classes.dart';

class CourseInstructorDetailsView extends GetView<CourseInstructorDetailsController> {
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
        final backgroundImage =
            instructor?.backgroundImage ??
            "https://images.unsplash.com/photo-1594824476967-48c8b964273f?auto=format&fit=crop&q=80&w=1000";
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
              child: Container(
                height: 300.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(backgroundImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  height: 300.h,
                  width: double.infinity,
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: SizedBox(height: 400.h)),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        UpcomingClassesCard(instructor: instructor),
                      ],
                    ),
                  ),
                ),
              ],
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


