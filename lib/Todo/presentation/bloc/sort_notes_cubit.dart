import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';

part 'sort_notes_state.dart';
part 'sort_notes_cubit.freezed.dart';

class SortNotesCubit extends Cubit<SortNotesState> {

  SortNotesCubit() : super(const SortNotesState.initial());
  bool isAscending = true;

  void sortNotes(List<NoteEntity>notes) {
    isAscending = !isAscending;
    try {
      notes.sort((a, b) {
        if (isAscending) {
          return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
        } else {
          return b.title!.toLowerCase().compareTo(a.title!.toLowerCase());
        }
      });
      emit(SortNotesState.success(notes));
    }  catch (e) {
      emit(SortNotesState.error(e.toString()));
    }
  }

}
