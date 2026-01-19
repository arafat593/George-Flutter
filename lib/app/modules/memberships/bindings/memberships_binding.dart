import 'package:get/get.dart';

import '../controllers/memberships_controller.dart';

class MembershipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MembershipsController>(() => MembershipsController());
  }
}
