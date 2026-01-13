import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/recovery_verification_otp_controller.dart';

class RecoveryVerificationOtpView
    extends GetView<RecoveryVerificationOtpController> {
  const RecoveryVerificationOtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecoveryVerificationOtpView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecoveryVerificationOtpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
