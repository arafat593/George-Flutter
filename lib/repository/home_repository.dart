import 'package:george/app/data/app_api_end_point.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/class_data.dart';
import 'package:george/services/api/api_services.dart';

class HomeRepository {
  ////////////// Contractures
  HomeRepository._privetContractures();
  static final HomeRepository _instance = HomeRepository._privetContractures();
  static HomeRepository get instance => _instance;

  /////////////// object
  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _api = AppApiEndPoint.instance;

  Future<List<ClassModel>> fetchClasses({
    required String date,
    String instructor = '',
  }) async {
    List<ClassModel> listOfData = [];
    try {
      Map<String, dynamic> queryParameter = {
        'scheduledAt': date,
        'page':1,
        "sortBy":"scheduledAt","sortOrder":'asc'
      };
      if (instructor.isNotEmpty) {
        queryParameter['search'] = instructor;
      }

      var response = await _apiServices.apiGetServices(
        _api.allClasses,
        queryParameters: queryParameter,
      );

      if (response != null) {
        if (response['classes'] is List) {
          for (var element in response['classes']) {
            listOfData.add(ClassModel.fromJson(element));
          }
        }
      }
    } catch (e) {
      errorLog('FetchClassesRep', e);
    }
    return listOfData;
  }
}
