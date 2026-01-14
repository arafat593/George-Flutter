import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_new_password_controller.dart';

class CreateNewPasswordView extends GetView<CreateNewPasswordController> {
  const CreateNewPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateNewPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreateNewPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
