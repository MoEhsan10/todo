import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_v2/my_app.dart';
import 'package:todo_app_v2/presentation/screens/auth/user_provider.dart';
import 'package:todo_app_v2/presentation/screens/home/tabs/tasks/provider/tasks_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => TasksProvider(),
      ),
      ChangeNotifierProvider(create: (context) => UserProvider()),
    ],
    child: MyApp(),
  ));

  await FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: const MyApp()));

}
