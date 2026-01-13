import 'package:get/get.dart';

import '../controllers/recovery_verification_otp_controller.dart';

class RecoveryVerificationOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecoveryVerificationOtpController>(
      () => RecoveryVerificationOtpController(),
    );
  }
}
