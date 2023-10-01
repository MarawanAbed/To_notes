import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:notes_app/Todo/domain/use_cases/add_notes.dart';
import 'package:notes_app/Todo/domain/use_cases/get_notes.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit({
    required this.addNotes,
    required this.getNotesUse,
  }) : super(NotesInitial());

  static NotesCubit get(context) => BlocProvider.of(context);
  final GetNotesUseCase getNotesUse;
  final AddNotesUseCase addNotes;

  bool hasChanges = false;
  bool isAscending = true; // Sorting order flag

  List<NoteEntity> _notes = []; // Private list

  List<NoteEntity> get notes => List.unmodifiable(_notes); // Expose an immutable list

  void addNote(NoteEntity note) {
    emit(AddNotesLoading());
    try {
      addNotes(note);
      _updateNotesList(); // Update the internal notes list
      emit(AddNotesSuccess());
    } catch (e) {
      debugPrint(e.toString());
      emit(AddNotesError());
    }
  }

  void getNotes() {
    emit(DisplayNotesLoading());
    try {
      _notes = getNotesUse();
      emit(DisplayNotesSuccess(_notes));
    } catch (er) {
      debugPrint(er.toString());
      emit(DisplayNotesError(er.toString()));
    }
  }

  Future<void> showConfirmationDialog(Function() onConfirm, context) async {
    final confirmed = await showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: const Text('Edit Note'),
        content: const Text('Are you sure you want to edit this note?'),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          BasicDialogAction(
            title: const Text('Edit'),
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
        ],
      ),
    );
    if (confirmed ?? false) {
      onConfirm();
    }
  }

  void searchNotes(String query) {
    if (query.isEmpty) {
      emit(DisplayNotesSuccess(_notes));
    } else {
      final filteredNotes = _notes.where((note) {
        final titleMatch = note.title!.toLowerCase().contains(query.toLowerCase());
        final subTitleMatch = note.subTitle!.toLowerCase().contains(query.toLowerCase());
        return titleMatch || subTitleMatch;
      }).toList();

      emit(DisplayNotesSuccess(filteredNotes));
    }
  }

  void sortNotes() {
    isAscending = !isAscending;
    _notes.sort((a, b) {
      if (isAscending) {
        return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
      } else {
        return b.title!.toLowerCase().compareTo(a.title!.toLowerCase());
      }
    });

    emit(DisplayNotesSuccess(_notes));
  }

  // Helper method to update the internal notes list after adding or editing a note
  void _updateNotesList() {
    _notes = getNotesUse();
  }
}
