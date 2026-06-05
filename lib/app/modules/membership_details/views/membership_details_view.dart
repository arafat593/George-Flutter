import 'package:flutter/material.dart';
import '../controllers/membership_details_controller.dart';
import '../../../widgets/app_image/app_image.dart';
import 'package:get/get.dart';

class MembershipDetailsView extends GetView<MembershipDetailsController> {
  const MembershipDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3EFE9),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppImage(
                  url: '',
                  path: "assets/images/network_placeholder_image.jpg",
                  fit: BoxFit.cover,
                ),

                /// Dark overlay
                Container(color: Colors.black.withValues(alpha: 0.4)),
              ],
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xff5D4037),
                            size: 20,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: Color(0xff5D4037),
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Text(
                        controller.type.value,
                        style: const TextStyle(
                          color: Color(0xff5D4037),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              decoration: const BoxDecoration(
                color: Color(0xffF3EFE9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Text(
                      controller.title.value,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5D4037),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      controller.subtitle.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff8D6E63),
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Obx(() {
                    if (controller.isActive.value) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Color(0xff5D4037),
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Days remaining: ${controller.daysRemaining.value} days",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff5D4037),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Text(
                        "Note: No refundable",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff5D4037),
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Color(0xff5D4037),
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => Text(
                          controller.validity.value,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff5D4037),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Obx(
                    () =>
                        (controller.type.value == 'Membership' ||
                            controller.isActive.value)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Start- ${controller.startDate.value}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xff5D4037),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    size: 16,
                                    color: Color(0xff5D4037),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "${controller.startDate.value} - ${controller.endDate.value}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: const Color(
                                    0xff5D4037,
                                  ).withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ),

                  // If active, show the classes
                  Obx(() {
                    if (controller.isActive.value &&
                        controller.classDetails.isNotEmpty) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            const Text(
                              "Included Classes",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5D4037),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: controller.classDetails.length,
                                itemBuilder: (context, index) {
                                  final classInfo =
                                      controller.classDetails[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(
                                          0xff5D4037,
                                        ).withValues(alpha: 0.1),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          classInfo.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: Color(0xff5D4037),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              size: 14,
                                              color: Color(0xff8D6E63),
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              classInfo.duration,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff8D6E63),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 14,
                                              color: Color(0xff8D6E63),
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                classInfo.location,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xff8D6E63),
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Spacer();
                    }
                  }),

                  Obx(() {
                    if (controller.isActive.value) {
                      return const SizedBox(height: 20);
                    }
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: controller.proceedToPayment,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff5D4037),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    "Proceed to Payment",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: List.generate(
                                      30,
                                      (index) => Expanded(
                                        child: Container(
                                          height: 1,
                                          color: index % 2 == 0
                                              ? Colors.white.withValues(
                                                  alpha: 0.3,
                                                )
                                              : Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    "Wallet balance ${controller.walletBalance.value}",
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
