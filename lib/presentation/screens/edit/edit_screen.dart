import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/core/utils/app_dark_styles.dart';

import '../../../core/utils/app_light_Styles.dart';
import '../../../core/utils/colors_manager.dart';
import '../../../firebase_functions/firebase_function.dart';
import '../../../models/task_model.dart';
import '../../../providers/theme_provider.dart';
import '../../Widgets/default_elevated_button.dart';
import '../../Widgets/default_textFormField.dart';
import '../auth/provider/user_provider.dart';
import '../home/tabs/tasks/provider/tasks_provider.dart';

class EditScreen extends StatefulWidget {
   EditScreen({super.key});
  static const String routeName ='/edit';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  TextEditingController titleController =TextEditingController();
  TextEditingController descriptionController =TextEditingController();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectedDate= DateTime.now();
  var formKey=GlobalKey<FormState>();
  TaskModel? task;




  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    final isLight = themeProvider.isLightTheme();
    if(task == null){
      task= ModalRoute.of(context)!.settings.arguments as TaskModel;
       selectedDate= task!.date;
      titleController.text = task!.title;
      descriptionController.text = task!.description;
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: ColorsManager.white,
        ),
        title: Text(AppLocalizations.of(context)!.todoList,
          style: ApplightStyle.appBarTextStyle,),
        backgroundColor: ColorsManager.blue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: ColorsManager.blue,
            height: screenHeight*0.1,
          ),
          Container(
            height: screenHeight *0.7,
            margin: REdgeInsets.symmetric(horizontal: 32,vertical: 20),
            padding: REdgeInsets.all(35),
            decoration: BoxDecoration(
              color:themeProvider.isLightTheme()? ColorsManager.white :ColorsManager.darkBLue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(AppLocalizations.of(context)!.editTask,style:themeProvider.isLightTheme()? ApplightStyle.bottomSheetTitle :AppDarkStyles.bottomSheetTitle,),
                    SizedBox(height: 52.h,),

                    DefaultTextFormField(
                      controller: titleController,
                      hintText: AppLocalizations.of(context)!.enterTaskTitle,
                      style: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : AppDarkStyles.hintStyle,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title can not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h,),

                    DefaultTextFormField(
                      controller: descriptionController,
                      hintText: AppLocalizations.of(context)!.enterTaskDesc,
                      style: isLight ? ApplightStyle.hintStyle!.copyWith(color: Colors.black) : AppDarkStyles.hintStyle,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Description can not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 33.h,),
                    Text(AppLocalizations.of(context)!.selectedDate,style: themeProvider.isLightTheme()? ApplightStyle.dateLabelStyle :AppDarkStyles.dateLabelStyle,),
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
                    SizedBox(height: 60.h,),
                    DefaultElevatedButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){updateTask();}
                        },
                        label: AppLocalizations.of(context)!.saveChanges),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  void updateTask(){
    String userId =Provider.of<UserProvider>(context,listen: false).currentUser!.id;
    task!.title =titleController.text;
    task!.description =descriptionController.text;
    task!.date =selectedDate;

    FirebaseFunction.editTask(task!,userId)
        .then((_){
      Navigator.pop(context);
      Provider.of<TasksProvider>(context,listen: false).getTasks(userId);
      Fluttertoast.showToast(
        msg: "Task edited successfully",
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
