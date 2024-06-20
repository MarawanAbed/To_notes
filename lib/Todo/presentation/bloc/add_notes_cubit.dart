import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/domain/use_cases/add_notes.dart';

part 'add_notes_state.dart';
part 'add_notes_cubit.freezed.dart';

class AddNotesCubit extends Cubit<AddNotesState> {
  AddNotesCubit(this.addNotes) : super(const AddNotesState.initial());

  final AddNotesUseCase addNotes;

  void addNote(NoteEntity note) {
    emit(AddNotesState.loading());
    try {
      addNotes(note);
      emit(AddNotesState.success());
    } catch (e) {
      emit(AddNotesState.error(e.toString()));
    }
  }

}
