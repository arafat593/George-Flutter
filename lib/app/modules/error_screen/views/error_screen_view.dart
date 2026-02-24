import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/error_screen_controller.dart';

class ErrorScreenView extends GetView<ErrorScreenController> {
  const ErrorScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ErrorScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ErrorScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
