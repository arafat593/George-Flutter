import 'package:flutter/material.dart';
import '../../../data/image_path.dart';
import '../../../methodes/call_studio.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/custom_progress.dart';
import '../../../widgets/image_top_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/app_text_styles.dart';
import '../../../methodes/call_whatsapp.dart';
import '../../../widgets/app_image/app_image.dart';
import '../../../widgets/snack_bar/app_snack_bar.dart';
import '../controllers/class_details_controller.dart';

class ClassDetailsView extends GetView<ClassDetailsController> {
  const ClassDetailsView({super.key});

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

        if (controller.classByID.value == null) {
          return const Center(child: Text("No data found"));
        }

        return Stack(
          children: [
            _buildBackgroundImage(),
            Positioned(
              top: 50.h,
              left: 16.w,
              child: ImageTopButton(onTap: () => Get.back()),
            ),
            _buildBookingDetailsSheet(),
          ],
        );
      }),
    );
  }

  Widget _buildBackgroundImage() {
    final image = controller.classByID.value?.imageUrl;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 450.h,
      child: Stack(
        children: [
          AppImage(
            url: image,
            width: AppSize.size.width,
            height: AppSize.size.width,
            fit: BoxFit.cover,
            path: "assets/images/network_placeholder_image.jpg",
          ),
          Container(
            width: AppSize.size.width,
            height: AppSize.size.width,
            color: Colors.black.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingDetailsSheet() {
    const Color sheetBg = Color(0xFFF1E9E0);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
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
              // SizedBox(height: 20.h),
              // _buildDateTimeSection(),
              SizedBox(height: 24.h),
              _buildLocationSection(),
              // Only show Book Now button if not from history
              if (controller.fromHistory.value == false) ...[
                SizedBox(height: 24.h),
                _buildBookNowButton(),
              ],
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
    return Obx(() {
      final title = controller.classByID.value?.title;
      final gender = controller.classByID.value?.gender;
      final classGender = (gender ?? '').trim().toLowerCase();
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.h,
              children: [
                Text(
                  title ?? "",
                  style: AppTextStyles.bold(22, color: brownColor),
                ),
                _buildDateTimeSection(),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  if (classGender == 'male' || classGender == 'both')
                    Icon(Icons.male_outlined, size: 24.r, color: brownColor),
                  if (classGender == 'female' || classGender == 'both')
                    Icon(Icons.female_outlined, size: 24.r, color: brownColor),
                ],
              ),
              Text(
                "QAR ${controller.classByID.value?.price.toString() ?? "0"}",
                style: AppTextStyles.semiBold24.apply(color: brownColor),
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _buildLevelTag() {
    const Color brownColor = Color(0xFF6B5345);
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE5D6C9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              controller.classByID.value?.difficulty ?? '',
              style: AppTextStyles.medium(12, color: brownColor),
            ),
          ),
          Obx(() {
            if (controller.price.value == 'QAR 0') {
              return Padding(
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
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildSpotsSection() {
    const Color brownColor = Color(0xFF6B5345);
    final bookedSeats = controller.classByID.value?.bookedSeats ?? 1;
    final maxParticipants = controller.classByID.value?.maxParticipants ?? 1;
    final availableSeat = controller.classByID.value?.availableSeats ?? 0;
    double progress = bookedSeats / maxParticipants;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available spots $availableSeat',
          style: AppTextStyles.regular(
            12,
            color: brownColor.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 8.h),
        CustomProgress(
          progress: progress,
          backgroundColor: Color(0xFFD6C8BE),
          progressColor: brownColor,
        ),
      ],
    );
  }

  Widget _buildInstructorSection() {
    const Color brownColor = Color(0xFF6B5345);
    return Obx(
      () => Row(
        children: [
          ClipOval(
            child: AppImage(
              url: controller.classByID.value?.instructor.avatar,
              path: "assets/images/network_placeholder_image.jpg",
              width: 52.r,
              height: 52.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Instructors',
                  style: AppTextStyles.regular(
                    10,
                    color: brownColor.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  controller.classByID.value?.instructor.name ?? '',
                  style: AppTextStyles.medium(18, color: brownColor),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final result = await Get.toNamed(
                '/instructor-details',
                arguments: controller.classByID.value?.instructor.id,
              );
              if (result != null && result is String) {
                controller.refreshData(result);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: brownColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            ),
            child: Text(
              'View Profile',
              style: AppTextStyles.bold(12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    const Color brownColor = Color(0xFF6B5345);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Class', style: AppTextStyles.bold(18, color: brownColor)),
        SizedBox(height: 12.h),
        Obx(() {
          final description = controller.classByID.value?.description ?? '';
          return GestureDetector(
            onTap: () => controller.isAboutExpanded.value =
                !controller.isAboutExpanded.value,
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.regular(
                  14,
                  color: brownColor.withValues(alpha: 0.8),
                ),
                children: [
                  TextSpan(
                    text: description.isNotEmpty
                        ? controller.isAboutExpanded.value
                              ? description
                              : '${description.substring(0, description.length ~/ 2)}... '
                        : 'No description added.',
                  ),
                  TextSpan(
                    text: controller.isAboutExpanded.value
                        ? 'See less'
                        : 'See more',
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
    final scheduledAt = controller.classByID.value?.scheduledAt;

    if (scheduledAt == null || scheduledAt.toString().isEmpty) {
      return const SizedBox();
    }

    DateTime? dateTime;

    try {
      dateTime = DateTime.parse(scheduledAt.toString());
    } catch (e) {
      return const SizedBox();
    }

    final dateFormat = DateFormat('MMMM d, yyyy').format(dateTime);
    const Color brownColor = Color(0xFF6B5345);

    return Row(
      children: [
        // Time Section
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.access_time,
                size: 15.r,
                color: brownColor.withValues(alpha: 0.6),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  controller.classByID.value?.duration ?? '',
                  style: AppTextStyles.medium(
                    12,
                    color: brownColor.withValues(alpha: 0.6),
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 10.w),

        // Date Section
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 15.r,
                color: brownColor.withValues(alpha: 0.6),
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  dateFormat,
                  style: AppTextStyles.medium(
                    12,
                    color: brownColor.withValues(alpha: 0.6),
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    const Color textColor = Color(0xFF6B5345);
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
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Obx(
              () => AppImage(
                url: controller.mapImage.value,
                width: double.infinity,
                height: 160.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          _buildLocationButtons(),
        ],
      ),
    );
  }

  Widget _buildLocationButtons() {
    const Color brownColor = Color(0xFF6B5345);
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              makePhoneCall(controller.classByID.value?.phone ?? '');
            },
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: const Color(0xFFDCC8B8),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: brownColor.withValues(alpha: 0.1)),
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
        Expanded(
          child: GestureDetector(
            onTap: () {
              openWhatsApp(controller.classByID.value?.phone ?? '');
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
                  Image.asset(
                    ImagePath.whatappButton,
                    height: 30.r,
                    width: 30.r,
                  ),
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
        onPressed: () {
          // controller.bookNow();
          AppSnackBar.success('Wating for payment implementation');
        },
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
