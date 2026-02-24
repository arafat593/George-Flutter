import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class MembershipDetailsController extends GetxController {
  final RxString type = "Membership".obs;

  final RxString title = "1 month Membership".obs;
  final RxString subtitle = "Access to regular classes for 30 days".obs;
  final RxString validity = "Valid for 1 month".obs;

  final RxString startDate = "2023-12-31".obs;
  final RxString endDate = "2024-02-18".obs;

  final RxString price = "QAR 100".obs;
  final RxString walletBalance = "QAR 200".obs;
  final RxBool isFromSuggestions = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    final Map<String, dynamic>? args = Get.arguments;
    if (args == null) return;

    type.value = _getValue(args, 'type', type.value);
    title.value = _getValue(args, 'title', title.value);
    subtitle.value = _getValue(args, 'subtitle', subtitle.value);
    validity.value = _getValue(args, 'validity', validity.value);
    price.value = _getValue(args, 'price', price.value);
    startDate.value = _getValue(args, 'startDate', startDate.value);
    endDate.value = _getValue(args, 'endDate', endDate.value);
    walletBalance.value = _getValue(args, 'walletBalance', walletBalance.value);
    isFromSuggestions.value = args['isFromSuggestions'] ?? false;
  }

  String _getValue(Map<String, dynamic> args, String key, String defaultValue) {
    final value = args[key];
    if (value != null && value.toString().isNotEmpty) {
      return value.toString();
    }
    return defaultValue;
  }

  void proceedToPayment() {
    Get.toNamed(
      Routes.checkout,
      arguments: {
        'itemName': title.value,
        'itemPrice': price.value,
        'fromMembership': true,
      },
    );
  }
}
