import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/firebase_functions/firebase_function.dart';
import 'package:todo_app_v2/models/task_model.dart';
import 'package:todo_app_v2/presentation/Widgets/default_elevated_button.dart';
import 'package:todo_app_v2/presentation/Widgets/default_textFormField.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';

import '../../../../auth/user_provider.dart';

class TaskBottomSheet extends StatefulWidget {
  const TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectedDate= DateTime.now();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.sizeOf(context).height*0.5,
        padding: REdgeInsets.all(20),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(15),right: Radius.circular(15)),
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Add new task',style: ApplightStyle.bottomSheetTitle,),
                SizedBox(height: 16.h,),
                DefaultTextFormField(
                    controller: titleController,
                    hintText: 'Enter task title',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title can not be empty';
                      }
                        return null;
                      },
                ),
                DefaultTextFormField(
                    controller: descriptionController,
                    hintText: 'Enter task description',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description can not be empty';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 16.h,),
                Text('Select date',style: ApplightStyle.dateLabelStyle,),
                SizedBox(height: 8.h,),
                InkWell(
                  onTap: ()async {
                    DateTime? dateTime = await showDatePicker(context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                      initialDate: selectedDate,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                    );
                    if (dateTime != null && dateTime !=selectedDate) {
                      selectedDate = dateTime;
                      setState(() {});
                    }
                  },
                    child: Text(dateFormat.format(selectedDate),style: ApplightStyle.dateStyle,)
                ),
                SizedBox(height: 28.h,),
                DefaultElevatedButton(
                    onPressed: () {
                        if(formKey.currentState!.validate()){addTask();}
                      },
                    label: 'Add'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addTask(){
    String userId =Provider.of<UserProvider>(context,listen: false).currentUser!.id;
    TaskModel task = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
    );
    FirebaseFunction.addTaskToFireStore(task,userId)
        .then((_){
          Navigator.pop(context);
          Provider.of<TasksProvider>(context,listen: false).getTasks(userId);
          Fluttertoast.showToast(
              msg: "Task added successfully",
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 5,
              backgroundColor: ColorsManager.blue,
          );
    },)
        .catchError((error){
            Fluttertoast.showToast(
                msg: "Something went wrong",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 5,
                backgroundColor: ColorsManager.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
    });
  }
}
