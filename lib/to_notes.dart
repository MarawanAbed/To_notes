import 'package:flutter/material.dart';
import 'package:notes_app/utils/constant/string.dart';
import 'package:notes_app/utils/routes/routes.dart';

class ToNotes extends StatelessWidget {
  const ToNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.toNotes,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade800,
      ),
      routes: AppRoutes.routes,
    );
  }
}
