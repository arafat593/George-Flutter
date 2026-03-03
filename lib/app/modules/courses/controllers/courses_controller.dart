import 'package:george/app/utils/app_log.dart';
import 'package:george/models/all_courses_model.dart';
import 'package:george/repository/course_repository.dart';
import 'package:get/get.dart';


class CoursesController extends GetxController {
  final CourseRepository _service = CourseRepository.instance;

  var isLoading = false.obs;
  var coursesList = <Course>[].obs;
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
