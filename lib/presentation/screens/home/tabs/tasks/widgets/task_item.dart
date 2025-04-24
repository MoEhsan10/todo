import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/firebase_functions/firebase_function.dart';
import 'package:todo_app_v2/models/task_model.dart';
import 'package:todo_app_v2/presentation/screens/edit/edit_screen.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';

import '../../../../auth/user_provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.task});

  TaskModel task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    String userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    return Container(
      margin: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          // A pane can dismiss the Slidable.
          // dismissible: DismissiblePane(onDismissed: () {}),

          children: [
            SlidableAction(
              onPressed: (context) {
                FirebaseFunction.deleteTaskFromFireStore(widget.task.id, userId)
                    .timeout(
                  Duration(microseconds: 100),
                  onTimeout: () {
                    Provider.of<TasksProvider>(context, listen: false)
                        .getTasks(userId);
                  },
                ).catchError((context) {
                  Fluttertoast.showToast(
                    msg: "Something wnt wrong",
                    toastLength: Toast.LENGTH_LONG,
                    timeInSecForIosWeb: 5,
                    backgroundColor: ColorsManager.red,
                  );
                });
              },
              backgroundColor: ColorsManager.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) {
                Navigator.of(context).pushNamed(EditScreen.routeName,arguments: widget.task);
              },
              backgroundColor: ColorsManager.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
            ),
          ],
        ),
        child: Container(
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
                color:widget.task.isDone ? ColorsManager.green: ColorsManager.blue,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.title,
                    style: widget.task.isDone
                        ? ApplightStyle.taskStyle!.copyWith(color: ColorsManager.green)
                        : ApplightStyle.taskStyle,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    widget.task.description,
                    style: ApplightStyle.taskDescriptionStyle,
                  ),
                ],
              ),
              const Spacer(),
              widget.task.isDone
                  ? TextButton(
                onPressed: () {
                  Provider.of<TasksProvider>(context, listen: false)
                      .toggleTaskStatus(widget.task, userId);
                },
                  child: Text(    'Done!',
                      style: ApplightStyle.taskDone,
                    ))
                  : InkWell(
                      onTap: () {
                        Provider.of<TasksProvider>(context, listen: false)
                            .toggleTaskStatus(widget.task, userId);
                      },
                      child: Container(
                        height: 34.h,
                        width: 69.w,
                        decoration: BoxDecoration(
                          color: ColorsManager.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.check,
                          color: ColorsManager.white,
                          size: 32.sp,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
