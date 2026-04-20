import 'package:flutter/material.dart';
import '../screens/profile_edit_screen.dart';
import '../common/styles/app_styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Update User Info',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppStyles.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppStyles.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      home: const ProfileEditScreen(),
    );
  }
}