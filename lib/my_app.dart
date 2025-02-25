import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/config/theme/app_theme.dart';
import 'package:todo_app_v2/presentation/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: {
          HomeScreen.routeName : (_) =>HomeScreen(),
        },
        initialRoute: HomeScreen.routeName,
        theme: AppTheme.light,
        themeMode:ThemeMode.light,
        darkTheme: AppTheme.dark,
      ),
    );
  }
}