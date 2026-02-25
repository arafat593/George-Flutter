import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../../app/data/app_api_end_point.dart';
import '../../models/all_courses_model.dart';

class CoursesService {
  final box = GetStorage();

  Future<AllCoursesModel?> getAllCourses() async {
    try {
      final url = Uri.parse(
        "${AppApiEndPoint.instance.baseUrl}${AppApiEndPoint.instance.allCourses}",
      );

      final token = box.read("token"); // 🔥 saved token

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

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
}