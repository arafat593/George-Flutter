import 'package:flutter/material.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/all_courses_model.dart';
import 'package:george/repository/course_repository.dart';
import 'package:get/get.dart';

class CoursesController extends GetxController {
  final CourseRepository _service = CourseRepository.instance;
  late ScrollController scrollController;

  var isLoading = false.obs;
  var coursesList = <Course>[].obs;
  final count = 0.obs;
  void increment() => count.value++;
  int currentPage = 1;
  int totalPages = 1;
  final RxBool isLoadingMore = false.obs;
  bool _isLoadingMoreInternal = false;

  Future<void> fetchCourses() async {
    try {
      isLoading(true);

      final result = await _service.getAllCourses(page: 1);

      if (result != null) {
        coursesList.clear(); // Clear existing list on fresh fetch
        coursesList.addAll(result.courses);
        currentPage = result.page;
        totalPages = result.totalPages;
      }
    } catch (e) {
      errorLog("Error: ", e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreCourses() async {
    try {
      if (_isLoadingMoreInternal || isLoadingMore.value) return;
      if (currentPage >= totalPages) return;

      _isLoadingMoreInternal = true;
      isLoadingMore.value = true;

      final nextPage = currentPage + 1;
      final result = await _service.getAllCourses(page: nextPage);

      if (result != null) {
        coursesList.addAll(result.courses);
        currentPage = result.page;
        totalPages = result.totalPages;
      }
    } catch (e) {
      errorLog("Pagination error", e);
    } finally {
      isLoadingMore.value = false;
      _isLoadingMoreInternal = false;
    }
  }

  void onInitialize() {
    try {
      fetchCourses();
      scrollController = ScrollController();
      scrollController.addListener(() {
        if (_isLoadingMoreInternal || isLoadingMore.value) return;

        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          loadMoreCourses();
        }
      });
    } catch (e) {
      errorLog('Course fetch error', e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAndToNamed(Routes.errorScreen);
      });
    }
  }

  void onAppClose() {
    try {
      scrollController.dispose();
    } catch (e) {
      errorLog("onAppClose", e);
    }
  }

  @override
  void onInit() {
    onInitialize();
    super.onInit();
  }

  @override
  void onClose() {
    onAppClose();
    super.onClose();
  }
}
