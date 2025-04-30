import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_dark_styles.dart';
import 'package:todo_app_v2/core/utils/app_light_Styles.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/firebase_functions/firebase_function.dart';
import 'package:todo_app_v2/models/task_model.dart';
import 'package:todo_app_v2/presentation/Widgets/default_elevated_button.dart';
import 'package:todo_app_v2/presentation/Widgets/default_textFormField.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../providers/theme_provider.dart';
import '../../../../auth/provider/user_provider.dart';

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
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = themeProvider.isLightTheme();
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.sizeOf(context).height*0.5,
        padding: REdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isLight ? ColorsManager.white :ColorsManager.darkBLue,
          borderRadius: BorderRadius.horizontal(left: Radius.circular(15),right: Radius.circular(15)),
        ),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(localizations.addNewTask,style:isLight ? ApplightStyle.bottomSheetTitle : AppDarkStyles.bottomSheetTitle,),
                SizedBox(height: 16.h,),
                DefaultTextFormField(
                    controller: titleController,
                    hintText: localizations.enterTaskTitle,
                    hintStyle: isLight ? ApplightStyle.hintStyle : AppDarkStyles.hintStyle,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title can not be empty';
                      }
                        return null;
                      },
                ),
                DefaultTextFormField(
                    controller: descriptionController,
                    hintText: localizations.enterTaskDesc,
                  hintStyle: isLight ? ApplightStyle.hintStyle : AppDarkStyles.hintStyle,
                  validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description can not be empty';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 16.h,),
                Text(localizations.selectedDate,style: isLight ? ApplightStyle.dateLabelStyle : AppDarkStyles.dateLabelStyle,),
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
                    label: localizations.add),
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
