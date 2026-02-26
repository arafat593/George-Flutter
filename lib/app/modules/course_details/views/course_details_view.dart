import 'package:flutter/material.dart';
import 'package:george/app/data/app_colors.dart';
import 'package:george/app/data/image_path.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/app_text_styles.dart';
import '../controllers/course_details_controller.dart';

class CourseDetailsView extends GetView<CourseDetailsController> {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6B5345)),
          );
        }

        if (controller.course.value == null) {
          return const Center(
            child: Text("Course not found"),
          );
        }

        return Stack(
          children: [
            _buildBackgroundImage(),
            _buildTopHeader(),
            _buildBookingDetailsSheet(),
          ],
        );
      }),
    );
  }

  Widget _buildTopHeader() {
    return Positioned(
      top: 50.h,
      left: 16.w,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: AppColors.bodyTextColor,
              size: 20.r,
            ),
            Text(
              'Back',
              style: AppTextStyles.bold(16, color: AppColors.bodyTextColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    final coverImage = controller.course.value?.coverImage ?? '';

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 450.h,
      child: Container(
        height: 300.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          image: coverImage.isNotEmpty
              ? DecorationImage(
            image: NetworkImage(coverImage),
            fit: BoxFit.cover,
            onError: (_, __) {},
          )
              : null,
        ),
        child: Container(
          height: 300.h,
          width: double.infinity,
          color: Colors.black.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  Widget _buildBookingDetailsSheet() {
    const Color sheetBg = Color(0xFFF1E9E0);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.55,
      maxChildSize: 0.95,
      snap: true,
      snapSizes: const [0.6, 0.95],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: sheetBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 30.h),
            children: [
              _buildDragHandle(),
              _buildHeaderSection(),
              SizedBox(height: 10.h),
              _buildLevelTag(),
              SizedBox(height: 16.h),
              _buildSpotsSection(),
              SizedBox(height: 24.h),
              _buildInstructorSection(),
              SizedBox(height: 24.h),
              _buildAboutSection(),
              SizedBox(height: 20.h),
              _buildDateTimeSection(),
              SizedBox(height: 24.h),
              _buildLocationSection(),
              Obx(() {
                if (controller.fromHistory.value == false) {
                  return Column(
                    children: [
                      SizedBox(height: 24.h),
                      _buildBookNowButton(),
                    ],
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Center(
      child: Container(
        width: 40.w,
        height: 4.h,
        margin: EdgeInsets.only(bottom: 24.h),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    const Color brownColor = Color(0xFF6B5345);
    return Obx(
          () {
        final course = controller.course.value;
        final gender = course?.gender ?? '';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                course?.title ?? '',
                style: AppTextStyles.bold(22, color: brownColor),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if (gender.toLowerCase() == 'male' ||
                        gender.toLowerCase() == 'both')
                      Icon(Icons.male_outlined, size: 24.r, color: brownColor),
                    if (gender.toLowerCase() == 'female' ||
                        gender.toLowerCase() == 'both')
                      Icon(Icons.female_outlined,
                          size: 24.r, color: brownColor),
                  ],
                ),
                Text(
                  controller.displayPrice.value,
                  style: AppTextStyles.bold(24, color: brownColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildLevelTag() {
    const Color brownColor = Color(0xFF6B5345);
    return Obx(() {
      final level = controller.course.value?.level ?? '';
      final isFree = controller.displayPrice.value == 'QAR 0';

      return Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            if (level.isNotEmpty)
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5D6C9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  level,
                  style: AppTextStyles.medium(12, color: brownColor),
                ),
              ),
            if (isFree)
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5D6C9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Membership',
                    style: AppTextStyles.medium(12, color: brownColor),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildSpotsSection() {
    const Color brownColor = Color(0xFF6B5345);
    return Obx(() {
      final available = controller.course.value?.availableSeat ?? 0;
      final percentage = controller.seatPercentage;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available spots $available',
            style: AppTextStyles.regular(
              12,
              color: brownColor.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            height: 10.h,
            decoration: BoxDecoration(
              color: const Color(0xFFD6C8BE),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Stack(
              children: [
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: 1 - percentage, // filled = booked seats
                  child: Container(
                    decoration: BoxDecoration(
                      color: brownColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildInstructorSection() {
    const Color brownColor = Color(0xFF6B5345);
    return Obx(() {
      final instructor = controller.course.value?.instructor;
      final name = instructor?.name ?? '';
      final image = instructor?.image ?? '';

      return Row(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/instructor-details'),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26.r,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage:
                  image.isNotEmpty ? NetworkImage(image) : null,
                  child: image.isEmpty
                      ? const Icon(Icons.person, color: Colors.grey)
                      : null,
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Instructor',
                      style: AppTextStyles.regular(
                        10,
                        color: brownColor.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      name,
                      style: AppTextStyles.medium(18, color: brownColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Get.toNamed('/instructor-details'),
            style: ElevatedButton.styleFrom(
              backgroundColor: brownColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
              padding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            ),
            child: Text(
              'View Profile',
              style: AppTextStyles.bold(12, color: Colors.white),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildAboutSection() {
    const Color brownColor = Color(0xFF6B5345);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Course', style: AppTextStyles.bold(18, color: brownColor)),
        SizedBox(height: 12.h),
        Obx(() {
          final desc = controller.course.value?.description ?? '';
          final expanded = controller.isAboutExpanded.value;
          final half = desc.length ~/ 2;
          final showFull = expanded || desc.length <= half;

          return GestureDetector(
            onTap: () =>
            controller.isAboutExpanded.value = !controller.isAboutExpanded.value,
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.regular(
                  14,
                  color: brownColor.withValues(alpha: 0.8),
                ),
                children: [
                  TextSpan(
                    text: showFull ? desc : '${desc.substring(0, half)}... ',
                  ),
                  TextSpan(
                    text: expanded ? '  See less' : '  See more',
                    style: AppTextStyles.bold(14, color: brownColor),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    const Color brownColor = Color(0xFF6B5345);
    return Obx(() {
      final duration = controller.course.value?.duration ?? '—';
      final date = controller.formattedDateLong;

      return Row(
        children: [
          Icon(
            Icons.access_time,
            size: 20.r,
            color: brownColor.withValues(alpha: 0.6),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              duration,
              style: AppTextStyles.medium(
                14,
                color: brownColor.withValues(alpha: 0.6),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 16.w),
          Icon(
            Icons.calendar_today_outlined,
            size: 20.r,
            color: brownColor.withValues(alpha: 0.6),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              date,
              style: AppTextStyles.medium(
                14,
                color: brownColor.withValues(alpha: 0.6),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLocationSection() {
    const Color textColor = Color(0xFF6B5345);
    return Obx(() {
      final locationName = controller.course.value?.location ?? '';
      final mapLink = controller.course.value?.locationMapLink ?? '';
      final phone = controller.course.value?.phone ?? '';

      return Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F2EF),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Location', style: AppTextStyles.bold(18, color: textColor)),
            if (locationName.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 16.r, color: textColor.withValues(alpha: 0.7)),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      locationName,
                      style: AppTextStyles.regular(13,
                          color: textColor.withValues(alpha: 0.8)),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 16.h),
            // Map thumbnail - Google Static Map দিয়ে দেখানো হচ্ছে
            // অথবা mapLink থেকে open করা যাবে
            GestureDetector(
              onTap: () async {
                if (mapLink.isNotEmpty) {
                  final uri = Uri.parse(mapLink);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri,
                        mode: LaunchMode.externalApplication);
                  }
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  height: 160.h,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.map_outlined,
                          size: 60, color: Colors.grey),
                      if (mapLink.isNotEmpty)
                        Positioned(
                          bottom: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: textColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Open in Maps',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _buildLocationButtons(phone: phone, mapLink: mapLink),
          ],
        ),
      );
    });
  }

  Widget _buildLocationButtons({
    required String phone,
    required String mapLink,
  }) {
    const Color brownColor = Color(0xFF6B5345);

    return Row(
      children: [
        // Call Studio
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (phone.isNotEmpty) {
                final uri = Uri.parse('tel:$phone');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              }
            },
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0xFFDCC8B8),
                borderRadius: BorderRadius.circular(12.r),
                border:
                Border.all(color: brownColor.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.call_outlined, size: 20.r, color: brownColor),
                  SizedBox(width: 8.w),
                  const Text(
                    'Call Studio',
                    style: TextStyle(
                      color: brownColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // WhatsApp
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (phone.isNotEmpty) {
                // phone number clean করে WhatsApp link তৈরি
                final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
                final uri = Uri.parse('https://wa.me/$cleaned');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri,
                      mode: LaunchMode.externalApplication);
                }
              }
            },
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: brownColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(ImagePath.whatappButton,
                      height: 30.r, width: 30.r),
                  SizedBox(width: 8.w),
                  const Text(
                    'WhatsApp',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookNowButton() {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton(
        onPressed: () => controller.bookNow(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6B5345),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Book Now',
          style: AppTextStyles.bold(18, color: Colors.white),
        ),
      ),
    );
  }
}