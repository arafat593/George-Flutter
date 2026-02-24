import 'package:flutter/material.dart';
import 'package:george/app/modules/auth/splash_screen/controllers/splash_screen_controller.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/repository/auth_repository.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final AuthRepository authRepository = AuthRepository.instance;
  late GlobalKey<FormState> formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode focusNode;
  final isPasswordVisible = false.obs;
  final isRememberMe = false.obs;
  RxBool isLoading = false.obs;

  Future<void> login() async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      var response = await authRepository.login(email: emailController.text.trim().toLowerCase(), password: passwordController.text.trim());
      if (response) {
        appGlobalUserData.value = await authRepository.getUser();
        Get.offAllNamed(Routes.customBottomNav);
      }
    } catch (e) {
      errorLog("login", e);
    } finally {
      isLoading.value = false;
    }
    // if (formKey.currentState?.validate() ?? false) {
    //   Get.offAllNamed('/custom-bottom-nav');
    // }
  }

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;
  void toggleRememberMe() => isRememberMe.value = !isRememberMe.value;

  void onAppInitial() {
    try {
      emailController = .new();
      passwordController = .new();
      formKey = .new();
      focusNode = .new();
    } catch (e) {
      errorLog("onAppInitial", e);
    }
  }

  void onAppClose() {
    try {
      emailController.dispose();
      passwordController.dispose();
      focusNode.dispose();
    } catch (e) {
      errorLog("onAppClose", e);
    }
  }

  @override
  void onInit() {
    onAppInitial();
    super.onInit();
  }

  @override
  void onClose() {
    onAppClose();
    super.onClose();
  }
}
