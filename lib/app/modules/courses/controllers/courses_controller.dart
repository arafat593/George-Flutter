import 'package:george/app/utils/app_log.dart';
import 'package:get/get.dart';

import '../../../../models/all_courses_model.dart';
import '../../../../services/api/courses_service.dart';

class CoursesController extends GetxController {
  final CoursesService _service = CoursesService();

  var isLoading = false.obs;
  var coursesList = <Courses>[].obs;
  final count = 0.obs;
  void increment() => count.value++;

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading(true);

      final result = await _service.getAllCourses();

      if (result != null) {
        coursesList.value = result.courses;
      }
    } catch (e) {
      errorLog("Error: ", e);
    } finally {
      isLoading(false);
    }
  }
}
