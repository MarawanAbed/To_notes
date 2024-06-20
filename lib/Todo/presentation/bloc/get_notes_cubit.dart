import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/domain/use_cases/get_notes.dart';

part 'get_notes_cubit.freezed.dart';
part 'get_notes_state.dart';

class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit(this._getNotesUse, this.noteBox)
      : super(const GetNotesState.initial()) {
    _watchNotes();
  }

  final GetNotesUseCase _getNotesUse;
  final Box<NoteEntity> noteBox;

  bool isAscending = true;

  void _watchNotes() {
    noteBox.watch().listen((event) {
      getNotes();
    });
  }

  List<NoteEntity> note = [];

  void getNotes() {
    final notes = _getNotesUse();
    note = notes;
    if (notes.isEmpty) {
      emit(GetNotesState.error('No notes found'));
    } else {
      emit(GetNotesState.success(notes));
    }
  }

  void searchNotes(String query) {
    if (query.isEmpty) {
      emit(GetNotesState.success(note));
    } else {
      final filteredNotes = note.where((note) {
        final titleMatch =
            note.title!.toLowerCase().contains(query.toLowerCase());
        final subTitleMatch =
            note.subTitle!.toLowerCase().contains(query.toLowerCase());
        return titleMatch || subTitleMatch;
      }).toList();
      emit(GetNotesState.success(filteredNotes));
    }
  }

  void sortNotes() async {
    emit(GetNotesState.loading());
    isAscending = !isAscending;
    note.sort((a, b) {
      if (isAscending) {
        return a.title!.toLowerCase().compareTo(b.title!.toLowerCase());
      } else {
        return b.title!.toLowerCase().compareTo(a.title!.toLowerCase());
      }
    });
    emit(GetNotesState.success(note));
  }

}
