import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_dark_styles.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/presentation/screens/auth/provider/user_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/widgets/task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../providers/theme_provider.dart';



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
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = themeProvider.isLightTheme();

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
                  style: isLight? ApplightStyle.appBarTextStyle : AppDarkStyles.appBarTextStyle,),
            ),
            Padding(
              padding: REdgeInsets.only(top: screenHeight*0.14),
              child: EasyInfiniteDateTimeLine(
                firstDate: DateTime.now().subtract(const Duration(days: 365)),
                focusDate: tasksProvider.selectedDate,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateChange: (selectedDate) => tasksProvider.getSelectedDateTask(selectedDate,userId),
                showTimelineHeader: false,
                dayProps: EasyDayProps(
                    height: 79.h,
                    width: 58.w,
                    dayStructure: DayStructure.dayStrDayNum,
                    activeDayStyle: DayStyle(
                      dayNumStyle:isLight? ApplightStyle.calenderSelectedItem?.copyWith(fontSize: 18) :AppDarkStyles.calenderSelectedItem,
                      dayStrStyle: isLight? ApplightStyle.calenderSelectedItem : AppDarkStyles.calenderSelectedItem,
                      monthStrStyle:isLight? ApplightStyle.calenderSelectedItem : AppDarkStyles.calenderSelectedItem,
                      decoration: BoxDecoration(
                          color: isLight ? ColorsManager.white :ColorsManager.darkBLue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    ),

                    todayStyle: DayStyle(
                      dayNumStyle:isLight? ApplightStyle.calenderUnSelectedItem?.copyWith(fontSize: 18):AppDarkStyles.calenderUnSelectedItem,
                      dayStrStyle:isLight? ApplightStyle.calenderUnSelectedItem : AppDarkStyles.calenderUnSelectedItem,
                      monthStrStyle: isLight? ApplightStyle.calenderUnSelectedItem : AppDarkStyles.calenderUnSelectedItem,
                      decoration: BoxDecoration(
                      color: isLight ? ColorsManager.white : ColorsManager.darkBLue,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                      ),

                    inactiveDayStyle: DayStyle(
                      dayNumStyle:isLight? ApplightStyle.calenderUnSelectedItem?.copyWith(fontSize: 18):AppDarkStyles.calenderUnSelectedItem,
                      dayStrStyle:isLight? ApplightStyle.calenderUnSelectedItem : AppDarkStyles.calenderUnSelectedItem,
                      monthStrStyle: isLight? ApplightStyle.calenderUnSelectedItem : AppDarkStyles.calenderUnSelectedItem,
                      decoration: BoxDecoration(
                          color: isLight ? ColorsManager.white : ColorsManager.darkBLue,
                          borderRadius: BorderRadius.all(Radius.circular(5))
                      ),
                    ),
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
