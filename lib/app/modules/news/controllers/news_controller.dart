import 'package:flutter/cupertino.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/models/news_model.dart';
import 'package:george/repository/news_repository.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rxn<NewsResponseModel> newsData = Rxn<NewsResponseModel>();
  final NewsRepository _newsRepository = NewsRepository.instance;

  Future<void> getAllNews() async {
    try {
      isLoading.value = true;
      newsData.value = await _newsRepository.getNews();
    } catch (e) {
      errorLog('News error', e);
    } finally {
      isLoading.value = false;
    }
  }

  void onInitialized() {
    try {
      getAllNews();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAndToNamed(Routes.errorScreen);
      });
    }
  }

  @override
  void onInit() {
    onInitialized();
    super.onInit();
  }
}
