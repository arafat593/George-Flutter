import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../../models/all_courses_model.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/app_refresh_indicator.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (controller.coursesList.isEmpty) {
                  return const Center(
                    child: Text("No Courses Found"),
                  );
                }

                return AppRefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchCourses();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      bottom: 100.h,
                      left: 24.w,
                      right: 24.w,
                    ),
                    itemCount: controller.coursesList.length,
                    itemBuilder: (context, index) {
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
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Courses',
            style: AppTextStyles.bold(
              24,
              color: AppColors.headlineColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(
      HomeController homeController,
      Courses course, {
        bool showBadge = true,
      }) {
    return Obx(() {
      final isPaid =
          homeController.isMembershipPaid.value && showBadge;

      final price =
      isPaid ? 'QAR 0' : 'QAR ${course.price}';

      final seatPercentage = course.totalSeat == 0
          ? 0.0
          : (course.availableSeat / course.totalSeat);

      return Container(
        margin: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Course Image
            GestureDetector(
              onTap: () => Get.toNamed(
                Routes.courseDetails,
                preventDuplicates: true,
                arguments: {
                  'id': course.id,
                  'title': course.title,
                  'price': price,
                },
              ),
              child: ClipRRect(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20.r)),
                child: Image.network(
                  course.coverImage,
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cacheHeight: 300,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180.h,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                    ),
                  ),
                ),
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
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Text(
                              course.level,
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
                  GestureDetector(
                    onTap: () => Get.toNamed(
                      Routes.courseDetails,
                      preventDuplicates: true,
                      arguments: {
                        'id': course.id,
                        'title': course.title,
                        'price': price,
                      },
                    ),
                    child: Text(
                      course.title,
                      style: AppTextStyles.medium(
                        20,
                        color: AppColors.headlineColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  /// Instructor
                  GestureDetector(
                    onTap: () =>
                        Get.toNamed(Routes.instructorDetails),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor:
                          Colors.grey.shade200,
                          backgroundImage:
                          course.instructor.image.isNotEmpty
                              ? NetworkImage(
                              course.instructor.image)
                              : null,
                          child:
                          course.instructor.image.isEmpty
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
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
                                color:
                                AppColors.headlineColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          size: 20.r,
                          color:
                          AppColors.headlineColor,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  /// Divider Line
                  Row(
                    children: List.generate(
                      20,
                          (index) => Expanded(
                        child: Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(
                              horizontal: 2.w),
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
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                                  color:
                                  AppColors.headlineColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      /// Seat Info
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Available spots ${course.availableSeat}",
                            style: AppTextStyles.regular(
                              10,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Container(
                            width: 80.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: Colors.grey
                                  .withValues(alpha: 0.2),
                              borderRadius:
                              BorderRadius.circular(
                                  4.r),
                            ),
                            child: FractionallySizedBox(
                              alignment:
                              Alignment.centerLeft,
                              widthFactor:
                              seatPercentage.clamp(
                                  0.0, 1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors
                                      .buttonPrimaryColor,
                                  borderRadius:
                                  BorderRadius
                                      .circular(4.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}