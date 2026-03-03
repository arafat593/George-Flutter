import 'package:flutter/material.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/faq_model.dart';
import 'package:george/repository/faq_repository.dart';

class FaqController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rxn<FAQModel> faq = Rxn<FAQModel>();

  final FAQRepository _faqRepository = FAQRepository.instance;

  @override
  void onInit() {
    super.onInit();
    onAppInitialize();
  }

  void onAppInitialize() {
    try {
      isLoading.value = true;
      fetchFAQ();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAndToNamed(Routes.errorScreen);
      });
    } finally {
      Future.delayed(const Duration(milliseconds: 300), () {
        isLoading.value = false;
      });
    }
  }

  Future<void> fetchFAQ() async {
    try {
      isLoading.value = true;

      faq.value = null;

      faq.value = await _faqRepository.getFAQ();
    } catch (e) {
      errorLog("fetchFAQ", e);
    } finally {
      isLoading.value = false;
    }
  }
}
