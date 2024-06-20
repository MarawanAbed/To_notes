part of 'get_notes_cubit.dart';

@freezed
class GetNotesState with _$GetNotesState {
  const factory GetNotesState.initial() = _Initial;

  const factory GetNotesState.loading() = Loading;

  const factory GetNotesState.success(List<NoteEntity> notes) = Success;

  const factory GetNotesState.error(String message) = Error;
}
