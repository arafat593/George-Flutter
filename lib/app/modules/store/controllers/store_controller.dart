import 'package:get/get.dart';

class StoreController extends GetxController {
  final products = <Map<String, dynamic>>[
    {
      "name": "Premium Eco-Friendly Yoga Mat (6mm)",
      "price": "QAR 2,450",
      "image": "https://picsum.photos/seed/yoga_mat/500/500",
      "available": 20,
      "isOutOfStock": false,
    },
    {
      "name": "100% Cotton Yoga Strap (8 ft)",
      "price": "QAR 2,450",
      "image": "https://picsum.photos/seed/yoga_strap/500/500",
      "available": 10,
      "isOutOfStock": false,
    },
    {
      "name": "Round Meditation Cushion (Zafu)",
      "price": "QAR 2,450",
      "image": "https://picsum.photos/seed/meditation_cushion/500/500",
      "available": 10,
      "isOutOfStock": false,
    },
    {
      "name": "Insulated Stainless Steel Water Bottle - 750ml",
      "price": "QAR 2,450",
      "image": "https://picsum.photos/seed/water_bottle/500/500",
      "available": 0,
      "isOutOfStock": true,
    },
    {
      "name": "High-Density Foam Yoga Block",
      "price": "QAR 2,450",
      "image": "https://picsum.photos/seed/yoga_block/500/500",
      "available": 10,
      "isOutOfStock": false,
    },
    {
      "name": "Premium Eco-Friendly Yoga Mat (6mm)",
      "price": "QAR 2,450",
      "image": "https://picsum.photos/seed/yoga_mat_2/500/500",
      "available": 10,
      "isOutOfStock": false,
    },
  ].obs;
}
