import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

ThemeData themeData() {
  return ThemeData(
    // scaffoldBackgroundColor: AppColors.whiteColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // backgroundColor: AppColors.whiteColor,
      // elevation: 0,
      // selectedLabelStyle: AppTextStyles.medium12,
      // unselectedLabelStyle: AppTextStyles.medium12,
    ),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
    ),
  );
}
