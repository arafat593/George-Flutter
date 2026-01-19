import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WalletController extends GetxController {
  // Mock Data
  final balance = 135.00.obs;
  final selectedPaymentMethod =
      0.obs; // 0: Apple Pay, 1: Google Pay, 2: Credit/Debit

  // Text Controllers for Credit/Debit Form
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final routingNumberCtrl = TextEditingController();
  final accountNumberCtrl = TextEditingController();
  final verifyAccountNumberCtrl = TextEditingController();

  @override
  void onClose() {
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    routingNumberCtrl.dispose();
    accountNumberCtrl.dispose();
    verifyAccountNumberCtrl.dispose();
    super.onClose();
  }

  final historyList = <Map<String, dynamic>>[
    {
      "title": "Wallet Top-up",
      "date": "Today, 10:23 AM",
      "amount": "+50.00",
      "isCredit": true,
    },
    {
      "title": "Class Booking",
      "date": "Today, 10:23 AM",
      "amount": "-15.00",
      "isCredit": false,
    },
    {
      "title": "Class Booking",
      "date": "Today, 10:23 AM",
      "amount": "-15.00",
      "isCredit": false,
    },
    {
      "title": "Class Booking",
      "date": "Today, 10:23 AM",
      "amount": "-15.00",
      "isCredit": false,
    },
    {
      "title": "Class Booking",
      "date": "Today, 10:23 AM",
      "amount": "-15.00",
      "isCredit": false,
    },
  ].obs;

  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }
}
