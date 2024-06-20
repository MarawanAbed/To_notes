import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  static NotesCubit get(context) => BlocProvider.of(context);

  bool hasChanges = false;
  bool isAscending = true; // Sorting order flag

  List<NoteEntity> _notes = []; // Private list

  List<NoteEntity> get notes =>
      List.unmodifiable(_notes); // Expose an immutable list

  // void addNote(NoteEntity note) {
  //   emit(AddNotesLoading());
  //   try {
  //     addNotes(note);
  //     emit(AddNotesSuccess());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     emit(AddNotesError());
  //   }
  // }
  //
  // void getNotes() {
  //   emit(DisplayNotesLoading());
  //   try {
  //     _notes = getNotesUse();
  //     emit(DisplayNotesSuccess(_notes));
  //   } catch (er) {
  //     debugPrint(er.toString());
  //     emit(DisplayNotesError(er.toString()));
  //   }
  // }

  void searchNotes(String query) {
    if (query.isEmpty) {
      emit(DisplayNotesSuccess(_notes));
    } else {
      final filteredNotes = _notes.where((note) {
        final titleMatch =
            note.title!.toLowerCase().contains(query.toLowerCase());
        final subTitleMatch =
            note.subTitle!.toLowerCase().contains(query.toLowerCase());
        return titleMatch || subTitleMatch;
      }).toList();
      emit(DisplayNotesSuccess(filteredNotes));
    }
  }

  void sortNotes(List<NoteEntity> notes) {
    isAscending = !isAscending;
    notes.sort((a, b) {
      if (isAscending) {
        return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
      } else {
        return b.title!.toLowerCase().compareTo(a.title!.toLowerCase());
      }
    });
    emit(DisplayNotesSuccess(notes));
  }
}
