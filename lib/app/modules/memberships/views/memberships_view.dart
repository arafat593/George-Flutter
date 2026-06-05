import 'package:flutter/material.dart';
import '../../../utils/app_size.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../../models/membership_catalogue_model.dart';
import '../../../../models/active_membership_model.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../controllers/memberships_controller.dart';

class MembershipsView extends GetView<MembershipsController> {
  const MembershipsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => CustomAppBar(
            title: controller.currentTab.value == 0 ? "Membership" : "Package",
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTabs(),
              SizedBox(height: 24.h),
              Obx(
                () => controller.currentTab.value == 0
                    ? _buildMembershipsContent()
                    : _buildPackagesContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setTab(0),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.currentTab.value == 0
                        ? const Color(0xFF6D4C41)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Membership",
                    style: AppTextStyles.bold(16).copyWith(
                      color: controller.currentTab.value == 0
                          ? Colors.white
                          : const Color(0xFF6D4C41),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setTab(1),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.currentTab.value == 1
                        ? const Color(0xFF6D4C41)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Package",
                    style: AppTextStyles.bold(16).copyWith(
                      color: controller.currentTab.value == 1
                          ? Colors.white
                          : const Color(0xFF6D4C41),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipsContent() {
    final length =
        controller.membershipDataModel.value?.memberships.length ?? 0;
    final membershipModel =
        controller.membershipDataModel.value?.memberships ?? [];
    if (controller.isLoading.value) {
      return SizedBox(
        height: Get.height * 0.75,
        width: Get.width,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.buttonPrimaryColor),
        ),
      );
    } else if (length == 0) {
      return SizedBox(
        height: Get.height * 0.75,
        width: Get.width,
        child: Center(child: Text("No memberships available")),
      );
    }
    return Column(
      children: [
        Obx(() {
          final activeList =
              controller.activeMembershipsModel.value?.memberships ?? [];
          final activeMemberships = activeList
              .where((m) => !m.name.toLowerCase().contains("pack"))
              .toList();

          if (controller.isActiveLoading.value) {
            return SizedBox(
              height: 100.h,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (activeMemberships.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: activeMemberships.map((active) {
              final expireDate =
                  "${active.endDate.year}-${active.endDate.month.toString().padLeft(2, '0')}-${active.endDate.day.toString().padLeft(2, '0')}";
              final startDateStr =
                  "${active.startDate.year}-${active.startDate.month.toString().padLeft(2, '0')}-${active.startDate.day.toString().padLeft(2, '0')}";
              final endDateStr = expireDate;
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.membershipDetails,
                    arguments: {
                      'type': 'Membership',
                      'title': active.name,
                      'subtitle': active.description,
                      'validity': 'Expires on $expireDate',
                      'price': 'QAR ${active.price.round()}',
                      'startDate': startDateStr,
                      'endDate': endDateStr,
                      'isActive': true,
                      'daysRemaining': active.daysRemaining,
                      'classDetails': active.classDetails,
                      'isFromSuggestions': Get.arguments != null
                          ? Get.arguments['isFromSuggestions']
                          : false,
                    },
                  );
                },
                child: _buildActiveMembershipCard(active),
              );
            }).toList(),
          );
        }),
        SizedBox(height: 20.h),
        ListView.builder(
          itemCount: length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) => GestureDetector(
            onTap: () {
              final model = membershipModel[index];
              Get.toNamed(
                Routes.membershipDetails,
                arguments: {
                  'type': 'Membership',
                  'title': model.name,
                  'price': 'QAR ${model.price.round()}',
                  'validity': 'Valid for ${model.durationDays} days',
                  'subtitle': model.description,
                  'membershipModel': model,
                  'isFromSuggestions': Get.arguments != null
                      ? Get.arguments['isFromSuggestions']
                      : false,
                },
              );
            },
            child: _buildMembershipOptionCard(
              type: "Membership",
              title: membershipModel[index].name,
              price: "QAR ${membershipModel[index].price.round()}",
              subtitle: membershipModel[index].description,
              validity: "Valid for ${membershipModel[index].durationDays} days",
              isAutoRenew: controller.autoRenew1Month,
              membershipModel: membershipModel[index],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPackagesContent() {
    return Column(
      children: [
        Obx(() {
          final activeList =
              controller.activeMembershipsModel.value?.memberships ?? [];
          final activePackages = activeList
              .where((m) => m.name.toLowerCase().contains("pack"))
              .toList();

          if (controller.isActiveLoading.value) {
            return SizedBox(
              height: 100.h,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          if (activePackages.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: activePackages.map((active) {
              final expireDate =
                  "${active.endDate.year}-${active.endDate.month.toString().padLeft(2, '0')}-${active.endDate.day.toString().padLeft(2, '0')}";
              final startDateStr =
                  "${active.startDate.year}-${active.startDate.month.toString().padLeft(2, '0')}-${active.startDate.day.toString().padLeft(2, '0')}";
              final endDateStr = expireDate;
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.membershipDetails,
                    arguments: {
                      'type': 'Package',
                      'title': active.name,
                      'subtitle': active.description,
                      'validity': 'Expires on $expireDate',
                      'price': 'QAR ${active.price.round()}',
                      'startDate': startDateStr,
                      'endDate': endDateStr,
                      'isActive': true,
                      'daysRemaining': active.daysRemaining,
                      'classDetails': active.classDetails,
                      'isFromSuggestions': Get.arguments != null
                          ? Get.arguments['isFromSuggestions']
                          : false,
                    },
                  );
                },
                child: _buildActivePackCard(active),
              );
            }).toList(),
          );
        }),
        SizedBox(height: 20.h),
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.membershipDetails,
              arguments: {
                'type': 'Package',
                'title': '10 Class Pack',
                'price': 'QAR 750',
                'validity': 'Valid for 2 months',
                'subtitle': 'Attend 10 classes',
                'isFromSuggestions': Get.arguments != null
                    ? Get.arguments['isFromSuggestions']
                    : false,
              },
            );
          },
          child: _buildMembershipOptionCard(
            type: "Package",
            title: "10 Class Pack",
            price: "QAR 750",
            subtitle: "Attend 10 classes",
            validity: "Valid for 2 months",
            isAutoRenew: controller.autoRenew1Month,
            membershipModel: MembershipModel(
              id: 'id',
              name: '',
              description: 'description',
              price: 0,
              durationDays: 5,
              allowedClasses: [],
              timeRestriction: 'timeRestriction',
              autoRenew: false,
              status: '',
              totalClasses: 0,
              classDetails: [],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivePackCard(ActiveMembershipModel active) {
    final expireDate =
        "${active.endDate.year}-${active.endDate.month.toString().padLeft(2, '0')}-${active.endDate.day.toString().padLeft(2, '0')}";
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF6D4C41),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          // decorative circle
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active Package",
                style: AppTextStyles.regular(
                  12,
                ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
              ),
              SizedBox(height: 8.h),
              Text(
                active.name,
                style: AppTextStyles.bold(22).copyWith(color: Colors.white),
              ),
              SizedBox(height: 20.h),
              Text(
                "Expires",
                style: AppTextStyles.regular(
                  12,
                ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
              ),
              Text(
                expireDate,
                style: AppTextStyles.medium(14).copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveMembershipCard(ActiveMembershipModel active) {
    final expireDate =
        "${active.endDate.year}-${active.endDate.month.toString().padLeft(2, '0')}-${active.endDate.day.toString().padLeft(2, '0')}";
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF6D4C41),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          // decorative circle
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Active Membership",
                  style: AppTextStyles.regular(
                    12,
                  ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
                ),
                SizedBox(height: 8.h),
                Text(
                  active.name,
                  style: AppTextStyles.bold(22).copyWith(color: Colors.white),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Expires",
                  style: AppTextStyles.regular(
                    12,
                  ).copyWith(color: Colors.white.withValues(alpha: 0.8)),
                ),
                Text(
                  expireDate,
                  style: AppTextStyles.medium(14).copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembershipOptionCard({
    required String type,
    required String title,
    required String price,
    String? subtitle,
    required String validity,
    required RxBool isAutoRenew,
    required MembershipModel membershipModel,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEBE3D9),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF6D4C41).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                membershipModel.name,
                style: AppTextStyles.bold(
                  18,
                ).copyWith(color: const Color(0xFF6D4C41)),
              ),
              Text(
                'QAR ${membershipModel.price.round()}',
                style: AppTextStyles.bold(
                  18,
                ).copyWith(color: const Color(0xFF6D4C41)),
              ),
            ],
          ),
          if (subtitle != null) ...[
            SizedBox(height: 8.h),
            Text(
              membershipModel.description,
              style: AppTextStyles.regular(
                14,
              ).copyWith(color: const Color(0xFF6D4C41).withValues(alpha: 0.7)),
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 18.sp,
                        color: const Color(0xFF6D4C41),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Valid for ${membershipModel.durationDays} months',
                        style: AppTextStyles.medium(
                          14,
                        ).copyWith(color: const Color(0xFF6D4C41)),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Obx(
                        () => Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: isAutoRenew.value,
                            onChanged: (val) => isAutoRenew.value = val,
                            activeThumbColor: const Color(0xFF6D4C41),
                            activeTrackColor: Colors.white,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: Colors.grey.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Auto Renew",
                        style: AppTextStyles.medium(
                          14,
                        ).copyWith(color: const Color(0xFF6D4C41)),
                      ),
                    ],
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () => Get.toNamed(
                  Routes.membershipDetails,
                  arguments: {
                    'type': type,
                    'title': title,
                    'price': price,
                    'validity': validity,
                    'subtitle': subtitle,
                    'membershipModel': membershipModel,
                    'isFromSuggestions': Get.arguments != null
                        ? Get.arguments['isFromSuggestions']
                        : false,
                  },
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6D4C41),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 10.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Buy",
                  style: AppTextStyles.bold(14).copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
