import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/colors.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

class AppThemes {
  static ThemeData getTheme() => Get.isPlatformDarkMode ? light : light;

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    dialogBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: AppColors.lightGray,
    bottomAppBarColor: Colors.white,
    cardColor: Colors.white,
    cardTheme: CardTheme(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.clipRadius),
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        surfaceTintColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
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
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
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
        fontSize: 26,
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
    dialogBackgroundColor: Colors.black,
    scaffoldBackgroundColor: AppColors.mediumBlack,
    backgroundColor: Colors.black,
    bottomAppBarColor: AppColors.mediumBlack,
    cardColor: AppColors.lightBlack,
    cardTheme: CardTheme(
      color: AppColors.lightBlack,
      surfaceTintColor: AppColors.lightBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.clipRadius),
      ),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        surfaceTintColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.mediumBlack,
      surfaceTintColor: AppColors.mediumBlack,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.mediumBlack,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
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
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
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
        fontSize: 26,
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
