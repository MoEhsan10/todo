import 'package:flutter/material.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';

class AppTheme{
  static ThemeData light =ThemeData(
    primaryColor: ColorsManager.blue,
    scaffoldBackgroundColor: ColorsManager.bgLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor:ColorsManager.white,
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      foregroundColor: ColorsManager.white,
      shape: CircleBorder(side: BorderSide(width: 4,color: ColorsManager.white)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: ColorsManager.blue,)
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorsManager.blue,
      )
    )
  );



  static ThemeData dark =ThemeData();
}