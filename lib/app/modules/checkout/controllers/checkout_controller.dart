import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../../models/product_details_model.dart';
import '../../../../repository/wallet_repository.dart';
import '../../../../repository/booking_repository.dart';
import '../../../utils/app_log.dart';
import '../../../widgets/snack_bar/app_snack_bar.dart';
import '../../wallet/controllers/wallet_controller.dart';
import '../../../routes/app_pages.dart';

class CheckoutController extends GetxController {
  ProductDetailsModel? product;

  final selectedPaymentMethod = 0.obs;

  final cartTotal = "".obs;
  final itemName = "".obs;
  final isFromShop = false.obs;
  final fromMembership = false.obs;
  final shouldHideSuggestions = false.obs;

  final checkoutType = "".obs; // 'class', 'course', 'membership', 'shop'
  final instructorName = "".obs;
  final duration = "".obs;
  final location = "".obs;
  final scheduledAt = Rxn<DateTime>();
  final validity = "".obs;
  final subtitle = "".obs;
  final imageUrl = "".obs;

  final classId = "".obs;
  final courseId = "".obs;
  final membershipPlanId = "".obs;
  final walletBalance = 0.0.obs;
  final isPaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args.containsKey('product')) {
        product = args['product'];
        checkoutType.value = 'shop';
        imageUrl.value = product?.thumbnail ?? "";
      } else {
        checkoutType.value =
            args['type'] ??
            (args['fromMembership'] == true ? 'membership' : '');
        imageUrl.value = args['imageUrl'] ?? "";
      }
      itemName.value = args['title'] ?? args['name'] ?? args['itemName'] ?? "";
      cartTotal.value = args['price'] ?? args['itemPrice'] ?? "QAR 0";
      isFromShop.value = args['isFromShop'] ?? (checkoutType.value == 'shop');
      fromMembership.value =
          args['fromMembership'] ?? (checkoutType.value == 'membership');

      instructorName.value = args['instructor'] ?? "";
      duration.value = args['duration'] ?? "";
      location.value = args['location'] ?? "";
      validity.value = args['validity'] ?? "";
      subtitle.value = args['subtitle'] ?? "";

      if (args['scheduledAt'] is DateTime) {
        scheduledAt.value = args['scheduledAt'];
      } else if (args['scheduledAt'] is String) {
        scheduledAt.value = DateTime.tryParse(args['scheduledAt']);
      }

      if (args.containsKey('class_id')) {
        classId.value = args['class_id'] ?? "";
      }

      if (args.containsKey('course_id')) {
        courseId.value = args['course_id'] ?? "";
      }

      if (args.containsKey('membership_plan_id')) {
        membershipPlanId.value = args['membership_plan_id'] ?? "";
      }

      // Hide suggestions ONLY if coming from a previous checkout's suggested list
      shouldHideSuggestions.value = args['isFromSuggestions'] ?? false;
    } else {
      cartTotal.value = "QAR 970";
    }

    fetchWalletBalance();
  }

  Future<void> fetchWalletBalance() async {
    try {
      final res = await WalletRepository.instance.getBalance();
      if (res != null) {
        walletBalance.value = res.balance;
      }
    } catch (e) {
      errorLog('fetchWalletBalance checkout controller', e);
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
      double priceVal = 0.0;
      try {
        final cleanPrice = cartTotal.value.replaceAll(RegExp(r'[^0-9.]'), '');
        priceVal = double.tryParse(cleanPrice) ?? 0.0;
      } catch (_) {}

      if (walletBalance.value < priceVal) {
        _showInsufficientFundsDialog();
        return;
      }
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

  Future<void> processPayment() async {
    final isCourse = checkoutType.value == 'course';
    final isShop = checkoutType.value == 'shop';
    final isMembership = checkoutType.value == 'membership' || fromMembership.value;

    if (isShop) {
      if (product == null || product!.id.isEmpty) {
        AppSnackBar.error('Error: Product is missing.');
        return;
      }
    } else if (isMembership) {
      if (membershipPlanId.value.isEmpty) {
        AppSnackBar.error('Error: Membership Plan ID is missing.');
        return;
      }
    } else if (isCourse) {
      if (courseId.value.isEmpty) {
        AppSnackBar.error('Error: Course ID is missing.');
        return;
      }
    } else {
      if (classId.value.isEmpty) {
        AppSnackBar.error('Error: Class ID is missing.');
        return;
      }
    }

    isPaying.value = true;
    try {
      // Show loading dialog
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: Color(0xff5d4037)),
        ),
        barrierDismissible: false,
      );

      final paymentMethod = selectedPaymentMethod.value == 0
          ? 'WALLET'
          : 'GATEWAY';

      final Map<String, dynamic>? response;
      if (isShop) {
        response = await BookingRepository.instance.checkoutOrder(
          productId: product!.id,
          quantity: product!.quantity,
          paymentMethod: paymentMethod,
        );
      } else if (isMembership) {
        response = await BookingRepository.instance.buyMembership(
          membershipPlanId: membershipPlanId.value,
          paymentMethod: paymentMethod,
        );
      } else if (isCourse) {
        response = await BookingRepository.instance.payCourse(
          courseId: courseId.value,
          paymentMethod: paymentMethod,
        );
      } else {
        response = await BookingRepository.instance.payBooking(
          classId: classId.value,
          paymentMethod: paymentMethod,
        );
      }

      Get.back(); // close loading dialog

      if (response != null) {
        final status = response['status'] ?? '';
        final message = response['message'] ?? 'Booking processed';

        if (paymentMethod == 'WALLET' && (status == 'CONFIRMED' || status == 'PAID' || status == 'ACTIVE')) {
          AppSnackBar.success(message);
          Get.toNamed(Routes.bookingConfirmed, arguments: {'message': message});
        } else if (paymentMethod == 'GATEWAY' && (status == 'PENDING' || status == 'CONFIRMED' || status == 'ACTIVE')) {
          final paymentUrl = response['payment_url'] ?? '';
          if (paymentUrl.isNotEmpty) {
            await _openPaymentBrowser(paymentUrl);
          } else {
            if (status == 'CONFIRMED' || status == 'ACTIVE') {
              AppSnackBar.success(message);
              Get.toNamed(Routes.bookingConfirmed, arguments: {'message': message});
            } else {
              AppSnackBar.error('Payment URL not found in gateway response.');
            }
          }
        } else {
          AppSnackBar.error(message);
        }
      } else {
        AppSnackBar.error('Payment failed. Please try again.');
      }
    } catch (e) {
      Get.back(); // close loading dialog in case of error
      AppSnackBar.error('Payment error: $e');
    } finally {
      isPaying.value = false;
    }
  }

  Future<void> _openPaymentBrowser(String url) async {
    // Close previous active browser if any
    if (WalletController.activeBrowser != null) {
      try {
        await WalletController.activeBrowser?.close();
      } catch (_) {}
    }

    final MyChromeSafariBrowser browser = MyChromeSafariBrowser();
    WalletController.activeBrowser = browser;

    appLog("[CheckoutController] Opening booking payment browser: $url");

    await browser.open(
      url: WebUri(url),
      settings: ChromeSafariBrowserSettings(
        shareState: CustomTabsShareState.SHARE_STATE_OFF,
        barCollapsingEnabled: true,
        isSingleInstance: true,
      ),
    );
  }
}
