import 'package:flutter/material.dart';
import 'package:george/app/modules/track_progress/widgets/class_attended_info.dart';

class ClassAttendedInfoSection extends StatelessWidget {
  const ClassAttendedInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClassAttendInfo(title: 'Classes attended this week:', number: 5),
        ClassAttendInfo(title: 'Classes attended this month:', number: 5),
        ClassAttendInfo(
          title: 'Classes attended since joining:',
          number: 5,
        ),
      ],
    );
  }
}