import 'package:george/app/data/app_api_end_point.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/privacy_policy_model.dart';
import 'package:george/services/api/api_services.dart';

class PrivacyPolicyRepository {

  //----Private constructor
  PrivacyPolicyRepository._privateConstructor();
  static final PrivacyPolicyRepository _instance =
      PrivacyPolicyRepository._privateConstructor();
  static PrivacyPolicyRepository get instance => _instance;

  /////////////// object
  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _api = AppApiEndPoint.instance;

  Future<PrivacyPolicy?> getPrivacyPolicy()async{
    try {
      var response = await _apiServices.apiGetServices(_api.privacyPolicy);
      if (response != null) {
        return PrivacyPolicy.fromJson(response);
      }
    } catch (e) {
      errorLog("getPrivacyPolicy repo", e);
    }
    return null;
  }
}
