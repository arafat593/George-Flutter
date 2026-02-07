import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  final orderHistory = <Map<String, dynamic>>[
    {
      'orderId': '#ORD-7782',
      'date': '24 Oct 2023',
      'amount': 'QAR 150.00',
      'status': 'Delivered',
      'items': 'Yoga Mat, Water Bottle',
      'image': 'https://picsum.photos/seed/order1/200',
    },
    {
      'orderId': '#ORD-7745',
      'date': '12 Oct 2023',
      'amount': 'QAR 85.00',
      'status': 'Delivered',
      'items': 'Resistance Band',
      'image': 'https://picsum.photos/seed/order2/200',
    },
    {
      'orderId': '#ORD-7690',
      'date': '05 Oct 2023',
      'amount': 'QAR 210.00',
      'status': 'Cancelled',
      'items': 'Protein Powder, Shaker',
      'image': 'https://picsum.photos/seed/order3/200',
    },
    {
      'orderId': '#ORD-7521',
      'date': '15 Sep 2023',
      'amount': 'QAR 45.00',
      'status': 'Delivered',
      'items': 'Gym Socks',
      'image': 'https://picsum.photos/seed/order4/200',
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
