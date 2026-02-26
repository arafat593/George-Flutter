import 'package:flutter/material.dart';
import 'package:george/app/modules/home/widgets/class_card.dart';
import 'package:george/app/utils/app_size.dart';
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
        return Center(child: CircularProgressIndicator());
      }
      if (controller.allClasses.isEmpty) {
        return Center(child: Text('No Classes Found'));
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.builder(
          itemCount: controller.allClasses.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
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
              classItem: classItem,
              progress: progress,
            );
          },
        ),
      );
    });
  }
}
// return ClassCard(
//               badge: classItem.difficulty.value,
//               title: title,
//               price: 'QAR 350',
//               time: '10:00 AM - 12:30 PM',
//               instructor: 'Michael Chen',
//               status: 'available',
//               spots: 5,
//               isMembershipPaid: false,
//             );