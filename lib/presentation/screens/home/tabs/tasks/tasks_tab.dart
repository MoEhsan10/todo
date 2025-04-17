import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/presentation/screens/auth/user_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/widgets/task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override

  bool shouldGetTasks=true;
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    String userId =Provider.of<UserProvider>(context,listen: false).currentUser!.id;
   if(shouldGetTasks){
     tasksProvider.getTasks(userId);
    shouldGetTasks=false;
   }
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
                child: Text(AppLocalizations.of(context)!.todoList,
                  style: ApplightStyle.appBarTextStyle,)
            ),
            Padding(
              padding: REdgeInsets.only(top: screenHeight*0.14),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                focusDate: tasksProvider.selectedDate,
                lastDate: DateTime.now().add(Duration(days: 365)),
                onDateChange: (selectedDate) => tasksProvider.getSelectedDateTask(selectedDate,userId),
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

                    todayStyle: DayStyle(
                      dayNumStyle:ApplightStyle.calenderUnSelectedItem?.copyWith(fontSize: 18),
                      dayStrStyle: ApplightStyle.calenderUnSelectedItem,
                      monthStrStyle: ApplightStyle.calenderUnSelectedItem,
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
          itemBuilder: (context, index) => TaskItem(task:tasksProvider.tasks[index],),itemCount: tasksProvider.tasks.length,))

      ],
    );
  }

}
