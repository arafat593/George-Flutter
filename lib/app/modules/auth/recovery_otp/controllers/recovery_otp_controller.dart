import 'dart:async';
import 'package:flutter/material.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:get/get.dart';

class RecoveryOtpController extends GetxController {
  final RxInt seconds = 90.obs;
  Timer? _timer;
  late TextEditingController otpController;

  void startTimer() {
    try {
      _timer?.cancel();
      seconds.value = 90;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (seconds.value > 0) {
          seconds.value--;
        } else {
          _timer?.cancel();
        }
      });
    } catch (e) {
      errorLog("startTimer", e);
    }
  }

  String get timerText {
    try {
      // Calculate the remaining minutes
      int minutes = (seconds % 3600) ~/ 60;

      // Calculate the remaining seconds
      num secs = seconds % 60;

      // Format minutes, and seconds to be 2 digits
      String formattedMinutes = minutes.toString().padLeft(2, '0');
      String formattedSeconds = secs.toString().padLeft(2, '0');

      return "$formattedMinutes:$formattedSeconds";
    } catch (e) {
      errorLog("formatSecondFunction", e);
      return "00:00";
    }
  }

  void onAppInitial() {
    try {
      otpController = .new();
      startTimer();
    } catch (e) {
      errorLog("onAppInitial", e);
    }
  }

  void onAppClose() {
    try {
      _timer?.cancel();
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
