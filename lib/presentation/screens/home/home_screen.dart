import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app_v2/core/utils/colors_manager.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/settings/settings_tab.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/tasks_tab.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/widgets/task_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs=[
    TasksTab(),
    SettingsTab(),
  ];
  int currentTabItem=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabItem],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 10.sp,
        padding: EdgeInsets.zero,
        color: ColorsManager.white,
        child: BottomNavigationBar(
          elevation: 0.sp,
          currentIndex: currentTabItem,
            onTap: (index) => setState(() {
              currentTabItem=index;
            }),
            items: [
              BottomNavigationBarItem(label: 'Tasks', icon: Icon(Icons.list,size: 32.sp,)),
              BottomNavigationBarItem(label: 'Settings', icon: Icon(Icons.settings,size: 32.sp,)),
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () => showModalBottomSheet(context: context,builder: (_) =>TaskBottomSheet()),
      child: Icon(Icons.add,size: 32.sp,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
