import 'package:get/get.dart';

import '../controllers/membership_details_controller.dart';

class MembershipDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MembershipDetailsController>(
      () => MembershipDetailsController(),
    );
  }
}
