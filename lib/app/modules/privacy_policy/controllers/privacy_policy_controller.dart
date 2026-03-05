import 'package:flutter/material.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/privacy_policy_model.dart';
import 'package:george/repository/privacy_policy_repository.dart';
import 'package:get/get.dart';

class PrivacyPolicyController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rxn<PrivacyPolicy> privacyPolicy = Rxn<PrivacyPolicy>();

  final PrivacyPolicyRepository _privacyPolicyRepository = PrivacyPolicyRepository.instance;

  void onAppInitialize() {
    try {
      isLoading.value = true;
      fetchPrivacyPolicy();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAndToNamed(Routes.errorScreen);
      });
    } 
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      isLoading.value = true;

      privacyPolicy.value = null;

      privacyPolicy.value = await _privacyPolicyRepository.getPrivacyPolicy();
    } catch (e) {
      errorLog("fetchPrivacyPolicy", e);
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onInit() {
    super.onInit();
    onAppInitialize();
  }
}
