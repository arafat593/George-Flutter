import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isRememberMe = false.obs;

  @override
  void onClose() {
    super.onClose();
  }

  void login() {
    if (formKey.currentState?.validate() ?? false) {
      Get.offAllNamed('/custom-bottom-nav');
    }
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
  void toggleRememberMe() => isRememberMe.value = !isRememberMe.value;
}
