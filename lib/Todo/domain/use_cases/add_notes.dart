import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/domain/repositories/notes_repo.dart';
import 'package:notes_app/utils/usecases/use_case.dart';

class AddNotesUseCase extends UseCase<dynamic, NoteEntity> {
  final NotesRepo _repo;

  AddNotesUseCase(this._repo);

  @override
  call([NoteEntity? parameter]) {
    return _repo.addNote(parameter!);
  }
}
