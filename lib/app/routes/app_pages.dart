import 'package:get/get.dart';

import '../modules/auth/create_new_password/bindings/create_new_password_binding.dart';
import '../modules/auth/create_new_password/views/create_new_password_view.dart';
import '../modules/auth/log_in/bindings/log_in_binding.dart';
import '../modules/auth/log_in/views/log_in_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/auth/recovery_otp/bindings/recovery_otp_binding.dart';
import '../modules/auth/recovery_otp/views/recovery_otp_view.dart';
import '../modules/auth/recovery_password/bindings/recovery_password_binding.dart';
import '../modules/auth/recovery_password/views/recovery_password_view.dart';
import '../modules/auth/registration/bindings/registration_binding.dart';
import '../modules/auth/registration/views/registration_view.dart';
import '../modules/auth/registration_otp/bindings/registration_otp_binding.dart';
import '../modules/auth/registration_otp/views/registration_otp_view.dart';
import '../modules/auth/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/auth/splash_screen/views/splash_screen_view.dart';
import '../modules/custom_bottom_nav/bindings/custom_bottom_nav_binding.dart';
import '../modules/custom_bottom_nav/views/custom_bottom_nav_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_BOTTOM_NAV,
      page: () => const CustomBottomNavView(),
      binding: CustomBottomNavBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOG_IN,
      page: () => const LogInView(),
      binding: LogInBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION_OTP,
      page: () => const RegistrationOtpView(),
      binding: RegistrationOtpBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY_OTP,
      page: () => const RecoveryOtpView(),
      binding: RecoveryOtpBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_NEW_PASSWORD,
      page: () => const CreateNewPasswordView(),
      binding: CreateNewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.RECOVERY_PASSWORD,
      page: () => const RecoveryPasswordView(),
      binding: RecoveryPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
  ];
}
