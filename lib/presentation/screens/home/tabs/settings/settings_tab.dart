import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';

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
                IconButton(onPressed: () {}, icon: Icon(Icons.logout,color: ColorsManager.blue,size: 25,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
