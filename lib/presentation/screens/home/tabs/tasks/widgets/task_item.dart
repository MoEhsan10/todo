import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/models/task_model.dart';

class TaskItem extends StatelessWidget {
   TaskItem({super.key, required this.task});

  TaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: REdgeInsets.symmetric(vertical: 8,horizontal: 20),
      padding: REdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 62.h,
            margin: REdgeInsets.only(right: 14.sp),
            color: ColorsManager.blue,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title,style: ApplightStyle.taskStyle,),
              SizedBox(height: 4.h,),
              Text(task.description,style: ApplightStyle.taskDescriptionStyle,),

            ],
          ),
          Spacer(),
          Container(
            height: 34.h,
            width: 69.w,
            decoration: BoxDecoration(
              color: ColorsManager.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.check,color: ColorsManager.white,size: 32.sp,),
          ),

        ],
      ),
    );
  }
}
