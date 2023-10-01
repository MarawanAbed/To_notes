import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/domain/use_cases/add_notes.dart';
import 'package:notes_app/Todo/domain/use_cases/get_notes.dart';
import 'package:notes_app/Todo/presentation/manager/notes_cubit.dart';
import 'package:notes_app/Todo/presentation/pages/notes_view.dart';
import 'package:notes_app/utils/constant/constant.dart';
import 'package:notes_app/utils/services/bloc_observer.dart';

import 'utils/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  setUp();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteEntity>(myBox);
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(
        getNotesUse: sl<GetNotesUseCase>(),
        addNotes: sl<AddNotesUseCase>(),
      )..getNotes(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey.shade800,
        ),
        home: const NotesViewScreen(),
      ),
    );
  }
}
