import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:musicians_shop/shared/styles/colors.dart';
import 'package:musicians_shop/shared/styles/styles.dart';

final class AppThemes {
  static ThemeData get appTheme => Get.isPlatformDarkMode ? dark : light;

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    dialogBackgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.pink,
      primary: Colors.pink,
      background: AppColors.lightGray,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      height: 56,
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      padding: EdgeInsets.zero,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.mediumGray,
    ),
    cardColor: Colors.white,
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.black45,
      clipBehavior: Clip.hardEdge,
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
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      modalBackgroundColor: Colors.white,
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
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.black,
    ),
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
      displaySmall: TextStyle(
        color: Colors.black,
        fontSize: 34,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        color: Colors.black,
        fontSize: 26,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    brightness: Brightness.dark,
    dialogBackgroundColor: Colors.black,
    scaffoldBackgroundColor: AppColors.mediumBlack,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.pink,
      primary: Colors.pink,
      background: Colors.black,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      height: 56,
      elevation: 0,
      color: AppColors.mediumBlack,
      surfaceTintColor: AppColors.mediumBlack,
      padding: EdgeInsets.zero,
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.lightBlack,
    ),
    cardColor: AppColors.lightBlack,
    cardTheme: CardTheme(
      elevation: 4,
      shadowColor: Colors.black,
      clipBehavior: Clip.hardEdge,
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
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.mediumBlack,
      surfaceTintColor: AppColors.mediumBlack,
      modalBackgroundColor: AppColors.mediumBlack,
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
    inputDecorationTheme: const InputDecorationTheme(
      suffixIconColor: Colors.white,
    ),
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
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
