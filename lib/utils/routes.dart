import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Todo/presentation/bloc/add_notes_cubit.dart';
import 'package:notes_app/Todo/presentation/bloc/get_notes_cubit.dart';
import 'package:notes_app/Todo/presentation/bloc/search_notes_cubit.dart';
import 'package:notes_app/Todo/presentation/bloc/sort_notes_cubit.dart';
import 'package:notes_app/Todo/presentation/pages/edit_notes/edit_notes.dart';
import 'package:notes_app/utils/services/services_locator.dart';

import '../Todo/presentation/pages/add_notes/add_notes.dart';
import '../Todo/presentation/pages/notes_view/notes_view.dart';

class AppRoutes {
  static const String notesView = '/';
  static const String addNotes = '/addNotes';
  static const String editNotes = '/editNotes';
  static final routes = <String, Widget Function(BuildContext)>{
    notesView: (context) =>
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
              sl<GetNotesCubit>()
                ..getNotes(),
            ),
            BlocProvider(
              create: (context) => sl<SortNotesCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<SearchNotesCubit>(),
            ),
          ],
          child: NotesViewScreen(),
        ),
    addNotes: (context) =>
        MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AddNotesCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<GetNotesCubit>(),
            ),
          ],
          child: AddNewNotes(),
        ),
    editNotes: (context) =>
        BlocProvider(
          create: (context) => sl<GetNotesCubit>(),
          child: EditNote(),
        ),
  };
}
