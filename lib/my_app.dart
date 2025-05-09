import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/config/theme/app_theme.dart';
import 'package:todo_app_v2/presentation/screens/auth/login_screen.dart';
import 'package:todo_app_v2/presentation/screens/auth/register_screen.dart';
import 'package:todo_app_v2/presentation/screens/home/home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          LoginScreen.routeName : (_) =>LoginScreen(),
          RegisterScreen.routeName : (_) =>RegisterScreen(),
        },
        initialRoute: LoginScreen.routeName,
        theme: AppTheme.light,
        themeMode:ThemeMode.light,
        darkTheme: AppTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('en'),
      ),
    );
  }
}