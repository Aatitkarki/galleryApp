import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.scaffoldBackground,
    textTheme: GoogleFonts.robotoTextTheme(),
    useMaterial3: true,
    fontFamily: GoogleFonts.roboto().fontFamily,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary, primary: AppColors.primary),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.scaffoldBackground,
      surfaceTintColor: AppColors.scaffoldBackground,
      // systemOverlayStyle: SystemUiOverlayStyle(
      //   statusBarColor: AppColors.scaffoldBackground,
      //   statusBarBrightness:
      //       Platform.isAndroid ? Brightness.dark : Brightness.light,
      //   statusBarIconBrightness:
      //       Platform.isAndroid ? Brightness.dark : Brightness.light,
      //   systemNavigationBarContrastEnforced: true,
      // ),
    ),
    splashColor: AppColors.white,
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.white,
      constraints: const BoxConstraints(
        minHeight: 44,
        maxWidth: double.infinity,
        minWidth: double.infinity,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
