import '../../../../models/membership_catalogue_model.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class MembershipDetailsController extends GetxController {
  final RxString type = "".obs;

  final RxString title = "".obs;
  final RxString subtitle = "".obs;
  final RxString validity = "".obs;

  final RxString startDate = "".obs;
  final RxString endDate = "".obs;

  final RxString price = "".obs;
  final RxString walletBalance = "".obs;
  final RxBool isFromSuggestions = false.obs;
  final Rx<MembershipModel?> membershipModel = Rx<MembershipModel?>(null);

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
    membershipModel.value = args['membershipModel'] as MembershipModel?;
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
