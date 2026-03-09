import 'package:flutter/material.dart';
import 'package:george/app/modules/auth/log_in/widgets/login_form.dart';

import 'package:george/app/utils/app_size.dart';
import 'package:george/app/widgets/auth_option_text.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/header_text.dart';
import '../controllers/log_in_controller.dart';

class LogInView extends GetView<LogInController> {
  const LogInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Header Section
              HeaderText(text: 'Welcome Back to\nInara Yoga'),
              SizedBox(height: 40.h),

              //Log In Form
              LogInForm(),
              SizedBox(height: 20.h),

              //Auth Option Text
              AuthOptions(
                seconds: 0.obs,
                titleText: "Don't have an account? ",
                optionText: 'Sign Up',
                onTap: () {
                  Get.toNamed(Routes.registration);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
