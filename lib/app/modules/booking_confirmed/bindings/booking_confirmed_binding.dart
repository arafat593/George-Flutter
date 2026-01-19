import 'package:get/get.dart';
import '../controllers/booking_confirmed_controller.dart';

class BookingConfirmedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingConfirmedController>(() => BookingConfirmedController());
  }
}
