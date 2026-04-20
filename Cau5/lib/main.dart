import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps/app.dart';
import 'controllers/task_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskController()),
      ],
      child: const MyApp(),
    ),
  );
}