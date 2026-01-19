import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              SizedBox(height: 30.h),
              _buildProfileImage(),
              SizedBox(height: 30.h),
              _buildForm(),
              SizedBox(height: 40.h),
              _buildSaveButton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 18.sp,
                color: const Color(0xFF6D4C41),
              ),
              Text(
                "Back",
                style: AppTextStyles.medium(
                  16,
                ).copyWith(color: const Color(0xFF6D4C41)),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Edit Profile",
              style: AppTextStyles.bold(
                20,
              ).copyWith(color: const Color(0xFF6D4C41)),
            ),
          ),
        ),
        SizedBox(width: 60.w), // Balance spacing
      ],
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: controller.pickImage,
      child: Stack(
        children: [
          Obx(() {
            return Container(
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: controller.profileImage.value.isNotEmpty
                      ? FileImage(File(controller.profileImage.value))
                            as ImageProvider
                      : const NetworkImage(
                          "https://picsum.photos/seed/profile/200",
                        ),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
          Positioned(
            right: 0,
            bottom: 5.h,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 18.r,
                color: const Color(0xFF6D4C41),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                "First name",
                "First name",
                controller.firstNameController,
              ),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: _buildTextField(
                "Last name",
                "Last name",
                controller.lastNameController,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          "Email",
          "example@gmail.com",
          controller.emailController,
        ),
        SizedBox(height: 16.h),
        _buildTextField("Username", "mdismail", controller.usernameController),
        SizedBox(height: 16.h),
        _buildTextField(
          "Phone number",
          "•••• •••• ••••",
          controller.phoneController,
        ),
        SizedBox(height: 48.h),
        _buildTextField(
          "Password",
          "•••• •••• ••••",
          controller.passwordController,
          isObscure: true,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          "New Password",
          "•••• •••• ••••",
          controller.newPasswordController,
          isObscure: true,
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          "Confirm Password",
          "•••• •••• ••••",
          controller.confirmPasswordController,
          isObscure: true,
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    String hint,
    TextEditingController textController, {
    bool isObscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bold(
            16,
          ).copyWith(color: const Color(0xFF6D4C41)),
        ),
        SizedBox(height: 8.h),
        CustomTextField(
          controller: textController,
          hintText: hint,
          obscureText: isObscure,
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.back(), // Mock save action
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6D4C41), // Brown
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          "Save",
          style: AppTextStyles.bold(16).copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
