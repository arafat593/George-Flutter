import 'package:flutter/foundation.dart';
import 'package:george/app/utils/app_log.dart';

class AppApiEndPoint {
  AppApiEndPoint._privateConstructor();
  static final AppApiEndPoint _instance = AppApiEndPoint._privateConstructor();
  static AppApiEndPoint get instance => _instance;

  //app use base
  final String domain = _getDomain();
  final String baseUrl = "${_getDomain()}/api/v1";
  final String liveServer = "https://";
  final String termsAndConditions = "termsAndConditions";
  final String about = "termsAndConditions";
  final String privacyPolicy = "termsAndConditions";
  final String login = "/auth/login";
  final String signUP = "/auth/register";
  final String authDeleteAccount = "login";
  final String userMe = "/users/me";
  final String userUpdate = "/users/update";
  final String changePassword = "login";
  final String userResendOtp = "login";
  final String authOtpVerify = "login";
  final String authForgotPassword = "login";
  final String authVerifyEmail = "login";
  final String authResetPassword = "login";
  final String allClasses = '/classes/';
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
