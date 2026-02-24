import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/not_found_screen_controller.dart';

class NotFoundScreenView extends GetView<NotFoundScreenController> {
  const NotFoundScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotFoundScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NotFoundScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
