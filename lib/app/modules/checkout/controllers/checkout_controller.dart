import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/product_details_model.dart';

class CheckoutController extends GetxController {

  late ProductDetailsModel product;

  final selectedPaymentMethod = 0.obs;

  final cartTotal = "".obs;
  final itemName = "".obs;
  final isFromShop = false.obs;
  final fromMembership = false.obs;
  final shouldHideSuggestions = false.obs;

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments['product'];
    if (Get.arguments != null && Get.arguments is Map) {
      itemName.value = Get.arguments['title'] ?? Get.arguments['name'] ?? "";
      cartTotal.value = Get.arguments['price'] ?? "QAR 0";
      isFromShop.value = Get.arguments['isFromShop'] ?? false;
      fromMembership.value = Get.arguments['fromMembership'] ?? false;

      // Hide suggestions ONLY if coming from a previous checkout's suggested list
      shouldHideSuggestions.value = Get.arguments['isFromSuggestions'] ?? false;
    } else {
      cartTotal.value = "QAR 970";
    }
  }


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

  final suggestedMemberships = <Map<String, dynamic>>[
    {
      "title": "3 month Membership",
      "price": "QAR 2750",
      "validity": "Valid for 3 months",
      "autoRenew": false,
    },
    {
      "title": "10 Class Pack",
      "price": "QAR 750",
      "validity": "Valid for 3 months",
      "autoRenew": false,
    },
  ].obs;

  void toggleAutoRenew(int index) {
    var item = suggestedMemberships[index];
    item['autoRenew'] = !item['autoRenew'];
    suggestedMemberships[index] = item;
  }

  void selectPaymentMethod(int index) {
    if (index == 0) {
      // Mock logic: Always show insufficient funds for demonstration as requested
      // In real app: if (walletBalance < cartTotal) ...
      _showInsufficientFundsDialog();
      return;
    }
    selectedPaymentMethod.value = index;
  }

  void _showInsufficientFundsDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.brown),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Not enough funds",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5D4037),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please top up your wallet first",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF5D4037),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}