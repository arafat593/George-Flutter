import 'package:get/get.dart';

class MyBookingsController extends GetxController {
  final RxInt selectedTab = 0.obs; // 0 for Upcoming, 1 for History

  void selectTab(int index) {
    selectedTab.value = index;
  }
}
