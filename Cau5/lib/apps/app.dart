import 'package:flutter/material.dart';
import '../views/task_view.dart';
import '../utils/app_styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task App MVC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppStyles.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const TaskView(),
    );
  }
}