import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constant/constant.dart';
import 'package:notes_app/models/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  static NotesCubit get(context) => BlocProvider.of(context);

  var titleController = TextEditingController();
  var subTitleController = TextEditingController();
  bool hasChanges = false;
  Color? selectedColor;
  bool isAscending = true; // Sorting order flag

  void selectColor(Color color) {
    selectedColor = color;
    emit(ChangeColorNotes());
  }

  addNote(NoteModel note) {
    emit(AddNotesLoading());
    var notesBox = Hive.box<NoteModel>(myBox);
    notesBox.add(note).then((value) {
      emit(AddNotesSuccess());
    }).catchError((er) {
      debugPrint(er.toString());
      emit(AddNotesError());
    });
  }

  List<NoteModel> notes = [];

  getNotes() {
    emit(DisplayNotesLoading());
    try {
      final notesBox = Hive.box<NoteModel>(myBox);
      notes = notesBox.values.toList();
      emit(DisplayNotesSuccess(notes));
    } catch (er) {
      debugPrint(er.toString());
      emit(DisplayNotesError());
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
      // If the query is empty, show all notes
      emit(DisplayNotesSuccess(notes));
    } else {
      // Filter notes based on the search query
      final filteredNotes = notes.where((note) {
        final titleMatch = note.title!.toLowerCase().contains(query.toLowerCase());
        final subTitleMatch = note.subTitle!.toLowerCase().contains(query.toLowerCase());
        return titleMatch || subTitleMatch;
      }).toList();

      emit(DisplayNotesSuccess(filteredNotes));
    }
  }

  void sortNotes() {
    // Toggle the sorting order
    isAscending = !isAscending;

    // Sort the notes list based on the sorting order
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
