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
      final isPaid = controller.isMembershipPaid.value;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            ClassCard(
              badge: 'Beginner',
              title: 'Morning Vinyasa Flow',
              price: isPaid ? 'QAR 0' : 'QAR 200',
              time: '8:00 AM - 8:30 AM',
              instructor: 'Sarah Jenkins',
              status: 'available',
              spots: 2,
              isMembershipPaid: isPaid,
            ),
            SizedBox(height: 16.h),
            ClassCard(
              badge: 'Beginner',
              title: 'Morning Vinyasa Flow',
              price: isPaid ? 'QAR 0' : 'QAR 200',
              time: '8:00 AM - 8:30 AM',
              instructor: 'Sarah Jenkins',
              status: 'fully_booked',
              isMembershipPaid: isPaid,
            ),
            SizedBox(height: 16.h),
            ClassCard(
              badge: 'Beginner',
              title: 'Morning Vinyasa Flow',
              price: isPaid ? 'QAR 0' : 'QAR 200',
              time: '8:00 AM - 8:30 AM',
              instructor: 'Sarah Jenkins',
              status: 'cancelled',
              isMembershipPaid: isPaid,
            ),
            SizedBox(height: 16.h),
            ClassCard(
              badge: 'Advanced',
              title: 'Power Yoga Workshop',
              price: 'QAR 350',
              time: '10:00 AM - 12:30 PM',
              instructor: 'Michael Chen',
              status: 'available',
              spots: 5,
              isMembershipPaid: false,
            ),
          ],
        ),
      );
    });
  }
}
