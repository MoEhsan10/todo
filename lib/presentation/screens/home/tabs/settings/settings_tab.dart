import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_dark_styles.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/firebase_functions/firebase_function.dart';
import 'package:todo_app_v2/presentation/screens/auth/login_screen.dart';
import 'package:todo_app_v2/presentation/screens/auth/provider/user_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/settings/widgets/language_drop_down.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/settings/widgets/theme_drop_down.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../providers/theme_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = themeProvider.isLightTheme();
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          localizations.settings,
          style: isLight ? ApplightStyle.appBarTextStyle : AppDarkStyles.appBarTextStyle,
        ),
        backgroundColor: ColorsManager.blue,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight*0.13,
            decoration: BoxDecoration(
              color: ColorsManager.blue,
            ),
          ),
          SizedBox(height: 25.h,),
          Padding(
            padding:  REdgeInsets.symmetric(horizontal: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LanguageDropDown(),
                SizedBox(height: 17.h,),
                ThemeDropDown(),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(localizations.logout,style: ApplightStyle.taskStyle,),
                    IconButton(onPressed: () {
                      FirebaseFunction.logout();
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                      Provider.of<TasksProvider>(context,listen: false).resetData();
                      Provider.of<UserProvider>(context,listen: false).updateUser(null);
                    }, icon: Icon(Icons.logout,color: ColorsManager.blue,size: 25,))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
