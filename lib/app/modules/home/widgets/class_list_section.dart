import 'package:flutter/material.dart';
import 'class_card.dart';
import '../../../utils/app_size.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class ClassListSection extends StatelessWidget {
  const ClassListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Obx(() {
      // final isPaid = controller.isMembershipPaid.value;
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: 100.h),
          child: Center(
            child: CircularProgressIndicator(color: Color(0xFF6B5345)),
          ),
        );
      }
      if (controller.allClasses.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Text(
              'No Classes Found',
              style: TextStyle(color: Color(0xFF6B5345), fontSize: 16.sp),
            ),
          ),
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            ListView.builder(
              itemCount: controller.allClasses.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final classItem = controller.allClasses[index];
                final title = classItem.title;
                final difficulity = classItem.difficulty;
                final price = classItem.price;
                final instructorName = classItem.instructor.name;
                final instructorImage = classItem.instructor.avatar;
                final availableSeats = classItem.availableSeats;
                final maxParticipants = classItem.maxParticipants;
                final bookedSeats = classItem.bookedSeats;
                final progress = bookedSeats / maxParticipants;
                final timeDuration = classItem.duration;
                final status = classItem.status;
                final classId = classItem.id;
                final gender = classItem.gender;
                controller.allInstructor.add(instructorName);
                controller.allClassName.add(title);
                return ClassCard(
                  badge: difficulity,
                  image: instructorImage ?? 'https://i.pravatar.cc/150?img=32',
                  title: title,
                  price: 'QAR $price',
                  time: timeDuration,
                  instructor: instructorName,
                  status: status,
                  availableSeats: availableSeats,
                  isMembershipPaid: false,
                  progress: progress,
                  classId: classId,
                  gender: gender,
                );
              },
            ),
            if (controller.isLoadingMore.value)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF6B5345)),
                ),
              ),
          ],
        ),
      );
    });
  }
}
