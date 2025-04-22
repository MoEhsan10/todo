import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/firebase_functions/firebase_function.dart';
import 'package:todo_app_v2/presentation/screens/auth/login_screen.dart';
import 'package:todo_app_v2/presentation/screens/auth/user_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logout',style: ApplightStyle.taskStyle,),
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
    );
  }
}
