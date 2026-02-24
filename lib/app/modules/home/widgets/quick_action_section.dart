import 'package:flutter/material.dart';
import 'package:george/app/data/image_path.dart';
import 'package:george/app/modules/home/widgets/home_view_call_us_dialog.dart';
import 'package:george/app/modules/home/widgets/quick_action_item.dart';
import 'package:get/get.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: QuickActionItem(
            iconPath: ImagePath.phone,
            label: 'Call Us',
            onTap: () => homeViewCallUsDialog(context: context),
          ),
        ),
        Expanded(
          child: QuickActionItem(
            iconPath: ImagePath.whatsapp,
            label: 'WhatsApp',
            onTap: () => homeViewCallUsDialog(context: context),
          ),
        ),
        Expanded(
          child: QuickActionItem(
            iconPath: ImagePath.location,
            label: 'Find Us',
            onTap: () => homeViewCallUsDialog(context: context),
          ),
        ),
        Expanded(
          child: QuickActionItem(
            iconPath: ImagePath.news,
            label: 'Our News',
            onTap: () => Get.toNamed('/news'),
          ),
        ),
      ],
    );
  }
}
