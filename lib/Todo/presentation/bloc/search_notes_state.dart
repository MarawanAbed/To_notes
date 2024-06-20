part of 'search_notes_cubit.dart';

@freezed
class SearchNotesState with _$SearchNotesState {
  const factory SearchNotesState.initial() = _Initial;

  const factory SearchNotesState.success(List<NoteEntity> notes) = Success;
  
  const factory SearchNotesState.error(String message) = Error;
}
