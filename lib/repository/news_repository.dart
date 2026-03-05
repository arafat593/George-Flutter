import 'package:george/app/data/app_api_end_point.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/news_model.dart';
import 'package:george/services/api/api_services.dart';

class NewsRepository {
  //---------Private Constructor-------
   NewsRepository._privateConstructor();

  static final NewsRepository _instance = NewsRepository._privateConstructor();

  static NewsRepository get instance => _instance;

  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _apiEndPoint = AppApiEndPoint.instance;

  Future<NewsResponseModel?> getNews() async {
    try {
      var response = await _apiServices.apiGetServices(_apiEndPoint.news);

      if (response != null) {
        return NewsResponseModel.fromJson(response);
      }
    } catch (e) {
      errorLog('News error', e);
    }
    return null;
  }
}
