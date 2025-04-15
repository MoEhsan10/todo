import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton(
      {super.key, required this.onPressed, required this.label});

  String label;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label,style: ApplightStyle.textButtonTitle,),
      style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.sizeOf(context).width, 42.h)),
    );
  }
}
