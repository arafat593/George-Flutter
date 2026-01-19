import 'package:get/get.dart';

class MembershipsController extends GetxController {
  final currentTab = 0.obs; // 0 for Membership, 1 for Package
  final autoRenew1Month = false.obs;
  final autoRenew3Month = false.obs;

  void setTab(int index) {
    currentTab.value = index;
  }
}
