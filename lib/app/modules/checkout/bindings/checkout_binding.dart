import 'package:get/get.dart';
import '../controllers/checkout_controller.dart';

class CheckoutBinding extends BindingsInterface {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutController>(() => CheckoutController());
  }
}
