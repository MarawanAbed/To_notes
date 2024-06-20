import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/utils/constant/constant.dart';
import 'package:notes_app/utils/routes.dart';
import 'package:notes_app/utils/services/bloc_observer.dart';

import 'utils/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteEntityAdapter());
  await Hive.openBox<NoteEntity>(myBox);
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade800,
      ),
      routes: AppRoutes.routes,
    );
  }
}
