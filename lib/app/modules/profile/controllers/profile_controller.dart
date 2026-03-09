import 'package:flutter/material.dart';
import 'package:george/app/modules/auth/splash_screen/controllers/splash_screen_controller.dart';
import 'package:george/app/routes/app_pages.dart';
import 'package:george/app/utils/app_log.dart';
import 'package:george/services/storage_services/get_storage_services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  GetStorageServices storageServices = GetStorageServices.instance;
  final appNotifications = true.obs;
  final whatsappNotifications = true.obs;
  final userData = appGlobalUserData;

  final userName = "".obs;
  final userEmail = "".obs;
  final membershipType = "".obs;
  final profileImage = "".obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }

    if (status.isPermanentlyDenied) {
      Get.snackbar(
        "Permission Denied",
        "Camera access is required to take a profile picture. Please enable it in settings.",
        mainButton: TextButton(
          onPressed: () => openAppSettings(),
          child: const Text("Settings", style: TextStyle(color: Colors.blue)),
        ),
        backgroundColor: Colors.white,
      );
      return;
    }

    if (status.isGranted) {
      try {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.camera,
        );
        if (image != null) {
          profileImage.value = image.path;
        }
      } catch (e) {
        Get.snackbar("Error", "Failed to capture image: $e");
      }
    } else {
      Get.snackbar("Permission Denied", "Camera permission is required.");
    }
  }

  final attendanceData = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    generateAttendanceData();
  }

  void generateAttendanceData() {
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    attendanceData.value = List.generate(12, (index) {
      return {
        "month": months[index],
        "total": 20,
        "attended": (index % 5) + 10,
        "classes_label": "${(index % 5) + 15} classes",
      };
    });
  }

  void toggleAppNotifications(bool value) => appNotifications.value = value;
  void toggleWhatsappNotifications(bool value) =>
      whatsappNotifications.value = value;

  Future<void> logout() async {
    try {
      Get.closeAllDialogs();
      Get.offAllNamed(Routes.logIn);
      await storageServices.logout();
    } catch (e) {
      errorLog("logout", e);
    }
  }
}
