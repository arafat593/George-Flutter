import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogInController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode focusNode;
  final isPasswordVisible = false.obs;
  final isRememberMe = false.obs;

  void login() {
    if (formKey.currentState?.validate() ?? false) {
      Get.offAllNamed('/custom-bottom-nav');
    }
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;
  void toggleRememberMe() => isRememberMe.value = !isRememberMe.value;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    focusNode = FocusNode();
  }

}
