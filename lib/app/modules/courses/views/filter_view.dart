import 'package:flutter/material.dart';
import 'package:george/app/utils/app_size.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    // Variable to track expansion locally if needed, but we can also put it in controller
    final RxBool isInstructorExpanded = false.obs;
    final RxBool isClassExpanded = false.obs;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20.sp,
                    color: AppColors.headlineColor,
                  ),
                  Text(
                    "Back",
                    style: AppTextStyles.semiBold(
                      20,
                      color: AppColors.headlineColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Filter',
              style: AppTextStyles.bold(28, color: AppColors.headlineColor),
            ),
            GestureDetector(
              onTap: () => controller.clearFilter(),
              child: Text(
                "Clear",
                style: AppTextStyles.semiBold(
                  20,
                  color: AppColors.headlineColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Instructor Section ---
                    Text(
                      'Search by instructor name',
                      style: AppTextStyles.regular(
                        14,
                        color: AppColors.headlineColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => _buildAccordion(
                        title:
                            controller.tempInstructors.any((e) => e['selected'])
                            ? controller.tempInstructors
                                  .firstWhere((e) => e['selected'])['name']
                                  .toString()
                            : 'Select an instructor',
                        isExpanded: isInstructorExpanded.value,
                        onTap: () => isInstructorExpanded.toggle(),
                        content: _buildSearchableList(
                          hintText: 'Search by Instructor name',
                          items: controller.tempInstructors
                              .where(
                                (e) => e['name'].toLowerCase().contains(
                                  controller.instructorSearch.value
                                      .toLowerCase(),
                                ),
                              )
                              .toList(),
                          onSearchChanged: (val) =>
                              controller.instructorSearch.value = val,
                          onChanged: (name) {
                            for (
                              var i = 0;
                              i < controller.tempInstructors.length;
                              i++
                            ) {
                              controller.tempInstructors[i]['selected'] =
                                  (controller.tempInstructors[i]['name'] ==
                                  name);
                            }
                            controller.tempInstructors.refresh();
                            isInstructorExpanded.value = false;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Class name',
                      style: AppTextStyles.regular(
                        14,
                        color: AppColors.headlineColor,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => _buildAccordion(
                        title: controller.tempClasses.any((e) => e['selected'])
                            ? controller.tempClasses
                                  .firstWhere((e) => e['selected'])['name']
                                  .toString()
                            : 'Select a class name',
                        isExpanded: isClassExpanded.value,
                        onTap: () => isClassExpanded.toggle(),
                        content: _buildSearchableList(
                          hintText: 'Search by Class Name',
                          items: controller.tempClasses
                              .where(
                                (e) => e['name'].toLowerCase().contains(
                                  controller.classSearch.value.toLowerCase(),
                                ),
                              )
                              .toList(),
                          onSearchChanged: (val) =>
                              controller.classSearch.value = val,
                          onChanged: (name) {
                            for (
                              var i = 0;
                              i < controller.tempClasses.length;
                              i++
                            ) {
                              controller.tempClasses[i]['selected'] =
                                  (controller.tempClasses[i]['name'] == name);
                            }
                            controller.tempClasses.refresh();
                            isClassExpanded.value = false;
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),
                    Text(
                      'Difficulty Level',
                      style: AppTextStyles.regular(
                        14,
                        color: AppColors.headlineColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => Wrap(
                        spacing: 12.w,
                        runSpacing: 12.h,
                        children: controller.difficulties.map((level) {
                          final isSelected =
                              level == controller.tempDifficulty.value;
                          return GestureDetector(
                            onTap: () => controller.tempDifficulty.value =
                                isSelected ? '' : level,
                            child: _buildChip(level, isSelected),
                          );
                        }).toList(),
                      ),
                    ),

                    SizedBox(height: 24.h),
                    Text(
                      'Gender',
                      style: AppTextStyles.regular(
                        14,
                        color: AppColors.headlineColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                      () => Wrap(
                        spacing: 12.w,
                        runSpacing: 12.h,
                        children: controller.genders.map((gender) {
                          final isSelected =
                              gender == controller.tempGender.value;
                          return GestureDetector(
                            onTap: () => controller.tempGender.value =
                                isSelected ? '' : gender,
                            child: _buildChip(gender, isSelected),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: ElevatedButton(
                onPressed: () => controller.applyFilter(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimaryColor,
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply Filter',
                  style: AppTextStyles.bold(18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccordion({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget content,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AppColors.cardBackgroundColor,
              borderRadius: isExpanded
                  ? BorderRadius.vertical(top: Radius.circular(12.r))
                  : BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regular(
                      14,
                      color: AppColors.headlineColor.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.headlineColor,
                ),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12.r),
              ),
            ),
            padding: EdgeInsets.all(16.r),
            child: content,
          ),
      ],
    );
  }

  Widget _buildSearchableList({
    required String hintText,
    required List<Map<String, dynamic>> items,
    required Function(String) onSearchChanged,
    required Function(String) onChanged,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFDCD3CB),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
              hintText: hintText,
              hintStyle: AppTextStyles.regular(14, color: Colors.grey),

              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
          ),
        ),

        SizedBox(height: 12.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () => onChanged(item['name']),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: Checkbox(
                        value: item['selected'],
                        onChanged: (_) => onChanged(item['name']),
                        activeColor: AppColors.buttonPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        side: BorderSide(
                          color: AppColors.headlineColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        item['name'],
                        style: AppTextStyles.regular(
                          16,
                          color: AppColors.headlineColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.buttonPrimaryColor
            : const Color(0xFFB7B0A8).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : AppColors.headlineColor.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.medium(
          14,
          color: isSelected
              ? Colors.white
              : AppColors.headlineColor.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
