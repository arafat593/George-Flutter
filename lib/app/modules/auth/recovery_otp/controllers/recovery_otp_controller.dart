import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecoveryOtpController extends GetxController {
  final RxInt seconds = 59.obs;
  Timer? _timer;
  final TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startTimer() {
    _timer?.cancel();
    seconds.value = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds.value > 0) {
        seconds.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  String get timerText {
    final int sec = seconds.value;
    final String secStr = sec.toString().padLeft(2, '0');
    return '00:$secStr sec';
  }
}
