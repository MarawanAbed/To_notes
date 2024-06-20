import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';

part 'search_notes_state.dart';
part 'search_notes_cubit.freezed.dart';

class SearchNotesCubit extends Cubit<SearchNotesState> {
  SearchNotesCubit() : super(const SearchNotesState.initial());

  void searchNotes(String query,List<NoteEntity>notes) {
    try {
      if (query.isEmpty) {
        emit(SearchNotesState.success(notes));
      } else {
        final filteredNotes = notes.where((note) {
          final titleMatch =
          note.title!.toLowerCase().contains(query.toLowerCase());
          final subTitleMatch =
          note.subTitle!.toLowerCase().contains(query.toLowerCase());
          return titleMatch || subTitleMatch;
        }).toList();
        emit(SearchNotesState.success(filteredNotes));
      }
    }  catch (e) {
      emit(SearchNotesState.error(e.toString()));
    }
  }


}
