import 'package:get/get.dart';

class FilterController extends GetxController {
  // --- Instructor ---
  final RxList<Map<String, dynamic>> instructors = RxList<Map<String, dynamic>>(
    [
      {'name': 'Jane Cooper', 'selected': false},
      {'name': 'Leslie Alexander', 'selected': false},
      {'name': 'Theresa Webb', 'selected': false},
      {'name': 'Jenny Wilson', 'selected': false},
    ],
  );
  final RxString instructorSearch = ''.obs;

  // --- Class Name ---
  final RxList<Map<String, dynamic>> classes = RxList<Map<String, dynamic>>([
    {'name': 'Inner Peace Yoga', 'selected': false},
    {'name': 'Serene Soul Yoga', 'selected': false},
    {'name': 'Harmony Yoga Studio', 'selected': false},
    {'name': 'Pure Breath Yoga', 'selected': false},
  ]);
  final RxString classSearch = ''.obs;

  // --- Difficulty ---
  final List<String> difficulties = ['Beginner', 'Intermediate', 'Advanced'];
  final RxString selectedDifficulty = ''.obs;

  // --- Gender ---
  final List<String> genders = ['Male', 'Female'];
  final RxString selectedGender = ''.obs;

  // Track if filter is applied
  final RxBool isFilterApplied = false.obs;

  // Temp variables for the filter screen (to allow canceling)
  final RxList<Map<String, dynamic>> tempInstructors =
      RxList<Map<String, dynamic>>([]);
  final RxList<Map<String, dynamic>> tempClasses = RxList<Map<String, dynamic>>(
    [],
  );
  final RxString tempDifficulty = ''.obs;
  final RxString tempGender = ''.obs;

  @override
  void onInit() {
    super.onInit();
    resetTemp();
  }

  void resetTemp() {
    tempInstructors.assignAll(
      instructors.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
    tempClasses.assignAll(
      classes.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
    tempDifficulty.value = selectedDifficulty.value;
    tempGender.value = selectedGender.value;
  }

  void applyFilter() {
    instructors.assignAll(
      tempInstructors.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
    classes.assignAll(
      tempClasses.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
    selectedDifficulty.value = tempDifficulty.value;
    selectedGender.value = tempGender.value;

    checkIfFilterActive();
    Get.back();
  }

  void clearFilter() {
    resetAll();
    Get.back();
  }

  void checkIfFilterActive() {
    bool hasInstructor = instructors.any((e) => e['selected'] == true);
    bool hasClass = classes.any((e) => e['selected'] == true);
    bool hasDifficulty = selectedDifficulty.value.isNotEmpty;
    bool hasGender = selectedGender.value.isNotEmpty;

    isFilterApplied.value =
        hasInstructor || hasClass || hasDifficulty || hasGender;
  }

  void resetAll() {
    for (var i = 0; i < instructors.length; i++) {
      instructors[i]['selected'] = false;
    }
    for (var i = 0; i < classes.length; i++) {
      classes[i]['selected'] = false;
    }
    selectedDifficulty.value = '';
    selectedGender.value = '';
    isFilterApplied.value = false;

    instructors.refresh();
    classes.refresh();
    resetTemp();
  }
}
