import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/registration_otp_controller.dart';

class RegistrationOtpView extends GetView<RegistrationOtpController> {
  const RegistrationOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegistrationOtpView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RegistrationOtpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
