import 'package:get/get.dart';

import '../controllers/registration_otp_controller.dart';

class RegistrationOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationOtpController>(
      () => RegistrationOtpController(),
    );
  }
}
