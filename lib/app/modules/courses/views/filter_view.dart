import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../widgets/app_refresh_indicator.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  // Mock Data for "Instructor"
  final List<Map<String, dynamic>> instructors = [
    {'name': 'Jane Cooper', 'selected': true},
    {'name': 'Leslie Alexander', 'selected': false},
    {'name': 'Theresa Webb', 'selected': false},
    {'name': 'Jenny Wilson', 'selected': false},
  ];
  bool isInstructorExpanded = false;
  String instructorSearch = '';
  final TextEditingController instructorController = TextEditingController();

  // Mock Data for "Class Name"
  final List<Map<String, dynamic>> classes = [
    {'name': 'Inner Peace Yoga', 'selected': true},
    {'name': 'Serene Soul Yoga', 'selected': false},
    {'name': 'Harmony Yoga Studio', 'selected': false},
    {'name': 'Pure Breath Yoga', 'selected': false},
  ];
  bool isClassExpanded = false;
  String classSearch = '';
  final TextEditingController classController = TextEditingController();

  // Mock Data for Difficulty
  final List<String> difficulties = ['Beginner', 'Intermediate', 'Advanced'];
  String selectedDifficulty = 'Beginner';

  // Mock Data for Gender
  final List<String> genders = ['Male', 'Female'];
  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              SizedBox(width: 16.w),
              Icon(
                Icons.arrow_back_ios,
                size: 18.sp,
                color: AppColors.headlineColor,
              ),
              Text(
                "Back",
                style: AppTextStyles.medium(16, color: AppColors.headlineColor),
              ),
            ],
          ),
        ),
        leadingWidth: 100.w,
        centerTitle: true,
        title: Text(
          'Filter',
          style: AppTextStyles.bold(24, color: AppColors.headlineColor),
        ),
      ),
      body: SafeArea(
        child: AppRefreshIndicator(
          onRefresh: () async {
            // Simulated refresh delay
            await Future.delayed(const Duration(seconds: 2));
          },
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
                _buildAccordion(
                  title: instructors.any((e) => e['selected'])
                      ? instructors.firstWhere((e) => e['selected'])['name']
                      : 'Select a instructor',
                  isExpanded: isInstructorExpanded,
                  onTap: () {
                    setState(() {
                      isInstructorExpanded = !isInstructorExpanded;
                    });
                  },
                  content: _buildSearchableList(
                    hintText: 'Search by Instructor name',
                    controller: instructorController,
                    items: instructors
                        .where(
                          (element) => element['name'].toLowerCase().contains(
                            instructorSearch.toLowerCase(),
                          ),
                        )
                        .toList(),
                    onSearchChanged: (val) {
                      setState(() {
                        instructorSearch = val;
                      });
                    },
                    onChanged: (index, val) {
                      setState(() {
                        final filteredList = instructors
                            .where(
                              (element) => element['name']
                                  .toLowerCase()
                                  .contains(instructorSearch.toLowerCase()),
                            )
                            .toList();
                        final actualName = filteredList[index]['name'];

                        for (var i = 0; i < instructors.length; i++) {
                          instructors[i]['selected'] =
                              (instructors[i]['name'] == actualName);
                        }
                        isInstructorExpanded = false; // Auto close
                      });
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                // --- Class Name Section ---
                Text(
                  'Class name',
                  style: AppTextStyles.regular(
                    14,
                    color: AppColors.headlineColor,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildAccordion(
                  title: classes.any((e) => e['selected'])
                      ? classes.firstWhere((e) => e['selected'])['name']
                      : 'Select a class name',
                  isExpanded: isClassExpanded,
                  onTap: () {
                    setState(() {
                      isClassExpanded = !isClassExpanded;
                    });
                  },
                  content: _buildSearchableList(
                    hintText: 'Search by Class Name',
                    controller: classController,
                    items: classes
                        .where(
                          (element) => element['name'].toLowerCase().contains(
                            classSearch.toLowerCase(),
                          ),
                        )
                        .toList(),
                    onSearchChanged: (val) {
                      setState(() {
                        classSearch = val;
                      });
                    },
                    onChanged: (index, val) {
                      setState(() {
                        final filteredList = classes
                            .where(
                              (element) => element['name']
                                  .toLowerCase()
                                  .contains(classSearch.toLowerCase()),
                            )
                            .toList();
                        final actualName = filteredList[index]['name'];

                        for (var i = 0; i < classes.length; i++) {
                          classes[i]['selected'] =
                              (classes[i]['name'] == actualName);
                        }
                        isClassExpanded = false; // Auto close
                      });
                    },
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
                Wrap(
                  spacing: 12.w,
                  children: difficulties.map((level) {
                    final isSelected = level == selectedDifficulty;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDifficulty = level;
                        });
                      },
                      child: _buildChip(level, isSelected),
                    );
                  }).toList(),
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
                Wrap(
                  spacing: 12.w,
                  children: genders.map((gender) {
                    final isSelected = gender == selectedGender;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = gender;
                        });
                      },
                      child: _buildChip(gender, isSelected),
                    );
                  }).toList(),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
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
                Text(
                  title,
                  style: AppTextStyles.regular(
                    14,
                    color: AppColors.headlineColor.withOpacity(0.6),
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: AppColors.headlineColor),
              ],
            ),
          ),
        ),
        if (isExpanded)
          Container(
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
    required TextEditingController controller,
    required Function(String) onSearchChanged,
    required Function(int, bool?) onChanged,
  }) {
    return Column(
      children: [
        // Search Box
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFDCD3CB),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextField(
            controller: controller,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
              hintText: hintText,
              hintStyle: AppTextStyles.regular(14, color: Colors.grey),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
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
                onTap: () => onChanged(index, !item['selected']),
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: Checkbox(
                        value: item['selected'],
                        onChanged: (val) => onChanged(index, val),
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.buttonPrimaryColor
            : const Color(0xFFB7B0A8),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.medium(
          14,
          color: isSelected
              ? Colors.white
              : AppColors.headlineColor.withOpacity(0.8),
        ),
      ),
    );
  }
}
