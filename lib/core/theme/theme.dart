import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightMode = ThemeData.light().copyWith(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ColorPallette.dark,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: ColorPallette.dark,
      ),
    ),
    switchTheme: const SwitchThemeData(
      trackOutlineColor: WidgetStatePropertyAll(
        ColorPallette.greyShade4,
      ),
      thumbColor: WidgetStatePropertyAll(
        ColorPallette.greyShade4,
      ),
    ),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      surface: ColorPallette.light,
      primary: ColorPallette.greyShade1,
      secondary: ColorPallette.greyShade3,
      tertiary: ColorPallette.greyShade4,
      primaryFixed: ColorPallette.primary,
    ),
    datePickerTheme: const DatePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      headerBackgroundColor: ColorPallette.primary,
      backgroundColor: ColorPallette.light,
      headerForegroundColor: ColorPallette.light,
      surfaceTintColor: ColorPallette.light,
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          ColorPallette.dark,
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          ColorPallette.dark,
        ),
      ),
      todayBackgroundColor: WidgetStatePropertyAll(
        ColorPallette.primary,
      ),
    ),

  );

  static final darkMode = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ColorPallette.light,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      iconTheme: IconThemeData(
        color: ColorPallette.light,
      ),
    ),
    switchTheme: const SwitchThemeData(
      trackOutlineColor: WidgetStatePropertyAll(
        ColorPallette.greyShade2,
      ),
      thumbColor: WidgetStatePropertyAll(
        ColorPallette.greyShade2,
      ),
    ),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: ColorPallette.dark,
      primary: ColorPallette.greyShade4,
      secondary: ColorPallette.greyShade3,
      tertiary: ColorPallette.greyShade2,
      primaryFixed: ColorPallette.primaryShade2,
    ),
    datePickerTheme: const DatePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      headerBackgroundColor: ColorPallette.primaryShade2,
      backgroundColor: ColorPallette.dark,
      headerForegroundColor: ColorPallette.greyShade3,
      surfaceTintColor: ColorPallette.dark,
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          ColorPallette.light,
        ),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          ColorPallette.light,
        ),
      ),
      todayBackgroundColor: WidgetStatePropertyAll(
        ColorPallette.primaryShade2,
      ),
    ),
  );
}
