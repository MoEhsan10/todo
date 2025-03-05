import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/models/task_model.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/widgets/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    List<TaskModel> tasks = List.generate(10,
          (index) => TaskModel(
              title: 'title $index' ,
              description: 'description $index',
              date: DateTime.now(),
          ),
    );

    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: screenHeight*0.19,
              width: double.infinity,
              color: ColorsManager.blue,
            ),
            Positioned(
                top: 45.sp,
                left: 20.sp,
                child: Text('To DO List',style: ApplightStyle.appBarTextStyle,)
            ),
            Padding(
              padding: REdgeInsets.only(top: screenHeight*0.14),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                focusDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                    height: 79.h,
                    width: 58.w,
                    dayStructure: DayStructure.dayStrDayNum,

                    activeDayStyle: DayStyle(
                      dayNumStyle:ApplightStyle.calenderSelectedItem?.copyWith(fontSize: 18),
                      dayStrStyle: ApplightStyle.calenderSelectedItem,
                      monthStrStyle: ApplightStyle.calenderSelectedItem,
                      decoration: BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    ),

                    inactiveDayStyle: DayStyle(
                      dayNumStyle:ApplightStyle.calenderUnSelectedItem?.copyWith(fontSize: 18),
                      dayStrStyle: ApplightStyle.calenderUnSelectedItem,
                      monthStrStyle: ApplightStyle.calenderUnSelectedItem,
                      decoration: BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
        Expanded(child: ListView.builder(
          padding: REdgeInsets.only(top: 20),
          itemBuilder: (context, index) => TaskItem(task:tasks[index],),itemCount: tasks.length,))

      ],
    );
  }
}
