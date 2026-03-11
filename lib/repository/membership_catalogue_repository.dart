import '../app/data/app_api_end_point.dart';
import '../app/utils/app_log.dart';
import '../models/membership_catalogue_model.dart';
import '../services/api/api_services.dart';

class MembershipCatalogueRepository {
  MembershipCatalogueRepository._privateConstructor();

  static final MembershipCatalogueRepository _instance =
      MembershipCatalogueRepository._privateConstructor();

  static MembershipCatalogueRepository get instance => _instance;

  final ApiServices _apiServices = ApiServices.instance;
  final AppApiEndPoint _apiEndPoint = AppApiEndPoint.instance;

  Future<MembershipResponseModel?> getMembershipCatalogue() async {
    try {
      var reponse = await _apiServices.apiGetServices(
        _apiEndPoint.membershipCatalogue,
      );
      if (reponse != null) {
        return MembershipResponseModel.fromJson(reponse);
      }
    } catch (e) {
      errorLog("Membership Catalogue", e);
    }
    return null;
  }
}
