import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'apps/app.dart';
import 'controllers/search_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductSearchController()),
      ],
      child: const MyApp(),
    ),
  );
}