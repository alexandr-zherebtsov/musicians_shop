import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/colors.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class AppThemes {
  static ThemeData getTheme() => Get.isPlatformDarkMode ? AppThemes.dark : AppThemes.light;

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: AppColors.lightGray,
    bottomAppBarColor: Colors.white,
    cardColor: Colors.white,
    cardTheme: CardTheme(
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.clipRadius),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    indicatorColor: Colors.pink,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),

      unselectedLabelStyle: TextStyle(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 34,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerColor: AppColors.mediumGray,
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.mediumBlack,
    backgroundColor: Colors.black,
    bottomAppBarColor: AppColors.mediumBlack,
    cardColor: AppColors.lightBlack,
    cardTheme: CardTheme(
      surfaceTintColor: AppColors.lightBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.clipRadius),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.mediumBlack,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    indicatorColor: Colors.pink,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.w400,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 28,
        fontWeight: FontWeight.w400,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    dividerColor: AppColors.lightBlack,
  );
}
