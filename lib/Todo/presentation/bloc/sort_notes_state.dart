part of 'sort_notes_cubit.dart';

@freezed
class SortNotesState with _$SortNotesState {
  const factory SortNotesState.initial() = _Initial;

  const factory SortNotesState.success(List<NoteEntity> notes) = Success;

  const factory SortNotesState.error(String message) = Error;
}
