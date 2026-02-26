import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../../app/data/app_api_end_point.dart';
import '../../models/all_courses_model.dart';

class CoursesService {
  final box = GetStorage();

  Map<String, String> get _headers {
    final token = box.read("token");
    return {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<AllCoursesModel?> getAllCourses() async {
    try {
      final url = Uri.parse(
        "${AppApiEndPoint.instance.baseUrl}${AppApiEndPoint.instance.allCourses}",
      );

      final response = await http.get(url, headers: _headers);

      print("Courses API URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AllCoursesModel.fromJson(data);
      } else {
        print("API Failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Courses Service Error: $e");
      return null;
    }
  }

  /// GET /api/v1/courses/{courseId}
  Future<Courses?> getCourseDetails(String courseId) async {
    try {
      final url = Uri.parse(
        "${AppApiEndPoint.instance.baseUrl}${AppApiEndPoint.instance.courseDetails(courseId)}",
      );

      final response = await http.get(url, headers: _headers);

      print("Course Details API URL: $url");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Backend হয় directly course object দেয়, নয়তো { course: {...} } দেয়
        // দুইটাই handle করা হচ্ছে
        if (data is Map<String, dynamic>) {
          final courseData = data.containsKey('course') ? data['course'] : data;
          return Courses.fromJson(courseData);
        }
        return null;
      } else {
        print("Course Details API Failed: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Course Details Service Error: $e");
      return null;
    }
  }
}