part of 'add_notes_cubit.dart';

@freezed
class AddNotesState with _$AddNotesState {
  const factory AddNotesState.initial() = _Initial;

  const factory AddNotesState.loading() = Loading;

  const factory AddNotesState.success() = Success;

  const factory AddNotesState.error(String error) = Error;
}
