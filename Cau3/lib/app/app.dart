import 'package:flutter/material.dart';
import '../screens/create_post_screen.dart';
import '../common/styles/app_styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppStyles.primaryColor,
        scaffoldBackgroundColor: AppStyles.bgColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const CreatePostScreen(),
    );
  }
}