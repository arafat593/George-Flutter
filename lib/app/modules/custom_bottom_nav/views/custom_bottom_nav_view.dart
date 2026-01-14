import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/custom_bottom_nav_controller.dart';

class CustomBottomNavView extends GetView<CustomBottomNavController> {
  const CustomBottomNavView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomBottomNavView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CustomBottomNavView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
