import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/to_notes.dart';
import 'package:notes_app/utils/constant/string.dart';
import 'package:notes_app/utils/services/bloc_observer.dart';

import 'utils/services/services_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUp();
  Bloc.observer = MyBlocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteEntityAdapter());
  await Hive.openBox<NoteEntity>(AppStrings.myBox);
  runApp(const ToNotes());
}
