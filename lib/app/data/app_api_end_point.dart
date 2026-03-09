import 'package:flutter/foundation.dart';
import 'package:george/app/utils/app_log.dart';

class AppApiEndPoint {
  AppApiEndPoint._privateConstructor();
  static final AppApiEndPoint _instance = AppApiEndPoint._privateConstructor();
  static AppApiEndPoint get instance => _instance;

  //app use base
  final String domain = _getDomain();
  final String baseUrl = "${_getDomain()}/api/v1";
  final String termsAndConditions = "/terms-conditions";
  final String about = "/about-us";
  final String privacyPolicy = "/privacy-policy";
  final String login = "/auth/login";
  final String refreshToken = "/auth/refresh";
  final String signUP = "/auth/register";
  final String signUpOtpVerify = "/auth/verify-otp";
  final String authDeleteAccount = "login";
  final String userMe = "/users/me";
  final String userUpdate = "/users/update";
  final String changePassword = "login";
  final String userResendOtp = "/auth/resend-otp";
  final String authOtpVerify = "login";
  final String authForgotPassword = "/auth/forgot-password";
  final String authVerifyEmail = "/auth/verify-otp";
  final String authResetPassword = "/auth/reset-password";
  final String allClasses = '/classes/';
  final String storeProduct = '/store/products';
  final String allCourses = '/courses/';
  String courseDetails(String courseId) => '/courses/$courseId';
  final String instructors = '/instructors';
  final String news = '/news';
  final String faq = '/faq';
  final String membershipCatalogue = '/memberships/catalogue';
  final String updatePassword = '/users/update-password';
}

String _getDomain() {
  String liveServer = "https://inara-backend.mtscorporate.com";
  String localServer = "https://inara-backend.mtscorporate.com";

  try {
    if (kDebugMode) {
      localServer;
      // return localServer;
    }
    return liveServer;
  } catch (e) {
    errorLog("_getDomain", e);
    return liveServer;
  }
}
