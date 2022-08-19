import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_colors.dart';
import 'package:quotes/core/utils/app_strings.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    hintColor: AppColors.hint,
    brightness: Brightness.light,
    fontFamily: AppStrings.fontFamily,
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      color: Colors.transparent,
    ),

    // Text Theme
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
        fontSize: 22,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
      bodySmall: TextStyle(
        color: AppColors.hint,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),

    // Button Theme
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      height: 55,
      buttonColor: AppColors.primary,
    ),
  );
}
