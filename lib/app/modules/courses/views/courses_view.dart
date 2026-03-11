import 'package:flutter/material.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../../models/all_courses_model.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/app_refresh_indicator.dart';
import '../../home/controllers/home_controller.dart';
import '../../home/widgets/available_spot_indicator.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(title: 'Courses', showBackButton: false),
      body: SafeArea(
        bottom: false,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.coursesList.isEmpty) {
            return const Center(child: Text("No Courses Found"));
          }

          return AppRefreshIndicator(
            onRefresh: () async {
              await controller.fetchCourses();
            },
            child: ListView.builder(
              controller: controller.scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 100.h, left: 24.w, right: 24.w),
              itemCount:
                  controller.coursesList.length +
                  (controller.isLoadingMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == controller.coursesList.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6B5345),
                      ),
                    ),
                  );
                }

                final course = controller.coursesList[index];
                final bool showBadge = index != 1;

                return _buildCourseCard(
                  homeController,
                  course,
                  showBadge: showBadge,
                );
              },
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCourseCard(
    HomeController homeController,
    Course course, {
    bool showBadge = true,
  }) {
    return Obx(() {
      final isPaid = homeController.isMembershipPaid.value && showBadge;

      final price = isPaid ? 'QAR 0' : 'QAR ${course.price}';
      print('✅✅✅${course.availableSeat}');

      final seatPercentage = course.maxParticipants == 0
          ? 0.0
          : (course.availableSeat / course.maxParticipants);

      return GestureDetector(
        onTap: () => Get.toNamed(
          Routes.courseDetails,
          preventDuplicates: true,
          arguments: course.id,
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 24.h),
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Course Image
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: AppImage(
                  url: course.imageUrl,
                  networkPlaceholderImage:
                      "assets/images/network_placeholder_image.jpg", // fallback
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 180.h,
                ),
              ),

              /// Content
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Level + Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                course.difficulty,
                                style: AppTextStyles.medium(
                                  12,
                                  color: Colors.grey,
                                ),
                              ),
                              if (isPaid) ...[
                                SizedBox(width: 8.w),
                                Text(
                                  '| Membership',
                                  style: AppTextStyles.medium(
                                    12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Text(
                          price,
                          style: AppTextStyles.bold(
                            20,
                            color: AppColors.headlineColor,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    /// Title
                    Text(
                      course.title,
                      style: AppTextStyles.medium(
                        20,
                        color: AppColors.headlineColor,
                      ),
                    ),

                    SizedBox(height: 12.h),

                    /// Instructor
                    Row(
                      children: [
                        ClipOval(
                          child: AppImage(
                            url: course.instructor.avatar,
                            path: "assets/images/network_placeholder_image.jpg",
                            width: 40.r, // radius * 2
                            height: 40.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Instructor',
                              style: AppTextStyles.regular(
                                10,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              course.instructor.name,
                              style: AppTextStyles.medium(
                                14,
                                color: AppColors.headlineColor,
                              ),
                            ),
                          ],
                        ),
                        // const Spacer(),
                        // Icon(
                        //   Icons.arrow_forward,
                        //   size: 20.r,
                        //   color: AppColors.headlineColor,
                        // ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    /// Divider Line
                    Row(
                      children: List.generate(
                        20,
                        (index) => Expanded(
                          child: Container(
                            height: 1,
                            margin: EdgeInsets.symmetric(horizontal: 2.w),
                            color: index % 2 == 0
                                ? Colors.grey.shade400
                                : Colors.transparent,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    /// Date + Seats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16.r,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${course.scheduledAt?.day}-${course.scheduledAt?.month}-${course.scheduledAt?.year}",
                                  style: AppTextStyles.regular(
                                    12,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  course.duration,
                                  style: AppTextStyles.medium(
                                    12,
                                    color: AppColors.headlineColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        /// Seat Info
                        SizedBox(
                          width: 100.w,
                          child: AvailableSpotsIndicator(
                            availableSeats: course.availableSeat,
                            progress: seatPercentage,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
