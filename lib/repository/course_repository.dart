import 'package:george/app/data/app_api_end_point.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/all_courses_model.dart';
import 'package:george/services/api/api_services.dart';

class CourseRepository {
  ////////////// Contractures
  CourseRepository._privetContractures();
  static final CourseRepository _instance = CourseRepository._privetContractures();
  static CourseRepository get instance => _instance;

  /////////////// object
  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _api = AppApiEndPoint.instance;

  Future<AllCoursesModel?> getAllCourses() async {
    try {
      var response = await _apiServices.apiGetServices(_api.allCourses);
      if (response != null) {
        return AllCoursesModel.fromJson(response);
      }
    } catch (e) {
      errorLog("getAllCourses repo", e);
    }
    return null;
  }

  Future<Courses?> getCourseDetails(String courseId) async {
    try {
      var response = await _apiServices.apiGetServices(_api.courseDetails(courseId));
      if (response != null) {
        final courseData = response.containsKey('course') ? response['course'] : response;
        return Courses.fromJson(courseData);
      }
    } catch (e) {
      errorLog("getCourseDetails repo", e);
    }
    return null;
  }
}
