import 'package:flutter/material.dart';
import 'package:final_project/models/strings.dart';
import 'package:final_project/screens/task_screen.dart';
import 'package:final_project/screens/user_screen.dart';
import 'package:final_project/screens/reg_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ThemeData _buildAppTheme() {
    final ThemeData data = ThemeData.dark();
    return data.copyWith(
        brightness: Brightness.dark,
        textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
            bodyText1: TextStyle(fontSize: 18)));
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/users': (context) => const UserScreen(),
        '/tasks': (context) => const TasksScreen(),
      },
      title: Strings.mainScreenTitle,
      theme: _buildAppTheme(),
    );
  }
}