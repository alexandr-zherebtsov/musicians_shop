import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicians_shop/shared/styles/colors.dart';

class AppThemes {
  static final ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
    androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: AppColors.lightGray,
    bottomAppBarColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
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
    ),
    dividerColor: AppColors.mediumGray,
  );
  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.pink,
    primarySwatch: Colors.pink,
    brightness: Brightness.dark,
    androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
    scaffoldBackgroundColor: AppColors.mediumBlack,
    backgroundColor: Colors.black,
    bottomAppBarColor: AppColors.mediumBlack,
    appBarTheme: const AppBarTheme(
      elevation: 0,
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
    ),
    dividerColor: AppColors.lightBlack,
  );
}
