import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController(text: "example@gmail.com");
  final usernameController = TextEditingController(text: "mdismail");
  final phoneController = TextEditingController(text: "•••• •••• ••••");
  final passwordController = TextEditingController(text: "•••• •••• ••••");
  final newPasswordController = TextEditingController(text: "•••• •••• ••••");
  final confirmPasswordController = TextEditingController(
    text: "•••• •••• ••••",
  );

  final profileImage = "".obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      profileImage.value = image.path;
    }
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
