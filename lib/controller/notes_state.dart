part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}
class ChangeColorNotes extends NotesState {}
class AddNotesLoading extends NotesState {}
class AddNotesSuccess extends NotesState {}
class AddNotesError extends NotesState {}

class DisplayNotesLoading extends NotesState {}
class DisplayNotesSuccess extends NotesState {
  final List<NoteModel>notes;

  DisplayNotesSuccess(this.notes);
}
class DisplayNotesError extends NotesState {}