import 'package:flutter/cupertino.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/app_log.dart';
import '../../../../models/membership_catalogue_model.dart';
import '../../../../models/active_membership_model.dart';
import '../../../../repository/membership_catalogue_repository.dart';
import 'package:get/get.dart';

class MembershipsController extends GetxController {
  final currentTab = 0.obs; // 0 for Membership, 1 for Package
  final autoRenew1Month = false.obs;
  final autoRenew3Month = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isActiveLoading = false.obs;

  Rxn<MembershipResponseModel> membershipDataModel =
      Rxn<MembershipResponseModel>();
  Rxn<ActiveMembershipResponseModel> activeMembershipsModel =
      Rxn<ActiveMembershipResponseModel>();

  final MembershipCatalogueRepository _catalogueRepository =
      MembershipCatalogueRepository.instance;

  void setTab(int index) {
    currentTab.value = index;
  }

  Future<void> getMembershipCatalogue() async {
    try {
      isLoading.value = true;

      membershipDataModel.value = await _catalogueRepository
          .getMembershipCatalogue();
    } catch (e) {
      errorLog('MembershipCatalogue', e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getActiveMemberships() async {
    try {
      isActiveLoading.value = true;
      activeMembershipsModel.value = await _catalogueRepository
          .getActiveMemberships();
    } catch (e) {
      errorLog('ActiveMemberships', e);
    } finally {
      isActiveLoading.value = false;
    }
  }

  void onInitialize() {
    try {
      getMembershipCatalogue();
      getActiveMemberships();
    } catch (e) {
      errorLog('Membership error', e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.toNamed(Routes.errorScreen);
      });
    }
  }

  @override
  void onInit() {
    onInitialize();
    super.onInit();
  }
}
