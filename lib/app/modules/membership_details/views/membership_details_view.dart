import 'package:flutter/material.dart';
import 'package:george/app/modules/membership_details/controllers/membership_details_controller.dart';
import 'package:get/get.dart';

class MembershipDetailsView extends StatelessWidget {
  MembershipDetailsView({super.key});

  final controller = Get.put(MembershipDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3EFE9), // Light beige background
      body: Stack(
        children: [
          // 1. Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height:
                MediaQuery.of(context).size.height * 0.6, // Takes up top 60%
            child: Image.network(
              "https://images.unsplash.com/photo-1545205597-3d9d02c29597?q=80&w=2070&auto=format&fit=crop", // Yoga/Peaceful image
              fit: BoxFit.cover,
            ),
          ),

          // 2. Header (Back Button & Title)
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
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
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
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50), // Balance the title centering
                  ],
                ),
              ),
            ),
          ),

          // 3. Content Card (Overlapping)
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5, // Start at 50%
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
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
                        color: Color(0xff8D6E63), // Lighter brown/grey
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Note: No refundable",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff5D4037),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Validity
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
                  const SizedBox(height: 24),

                  // Dates Section
                  Obx(
                    () => controller.type.value == 'Membership'
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: Column(
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
                                    ).withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  const Spacer(),

                  // Proceed to Payment Button
                  GestureDetector(
                    onTap: controller.proceedToPayment,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff5D4037), // Dark brown button
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
                          // Dashed Divider
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: List.generate(
                                30,
                                (index) => Expanded(
                                  child: Container(
                                    height: 1,
                                    color: index % 2 == 0
                                        ? Colors.white.withOpacity(0.3)
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Obx(
                              () => Text(
                                "Wallet balance ${controller.walletBalance.value}",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
