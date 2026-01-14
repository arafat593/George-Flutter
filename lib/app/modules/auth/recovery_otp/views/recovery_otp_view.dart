import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/recovery_otp_controller.dart';

class RecoveryOtpView extends GetView<RecoveryOtpController> {
  const RecoveryOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecoveryOtpView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecoveryOtpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
