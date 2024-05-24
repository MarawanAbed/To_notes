import 'package:get_it/get_it.dart';
import 'package:notes_app/Todo/data/data_sources/local_data_source.dart';
import 'package:notes_app/Todo/data/data_sources/local_data_source_impl.dart';
import 'package:notes_app/Todo/data/repositories/notes_repo_impl.dart';
import 'package:notes_app/Todo/domain/repositories/notes_repo.dart';
import 'package:notes_app/Todo/domain/use_cases/add_notes.dart';
import 'package:notes_app/Todo/domain/use_cases/get_notes.dart';
import 'package:notes_app/Todo/presentation/manager/notes_cubit.dart';

final sl = GetIt.instance;

setUp() {
  sl.registerLazySingleton<NotesRepo>(() => NotesRepoImpl(sl.call()));
  sl.registerLazySingleton<GetNotesUseCase>(() => GetNotesUseCase(sl.call()));
  sl.registerLazySingleton<AddNotesUseCase>(() => AddNotesUseCase(sl.call()));
  sl.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());
  sl.registerFactory(
      () => NotesCubit(addNotes: sl.call(), getNotesUse: sl.call()));
}
