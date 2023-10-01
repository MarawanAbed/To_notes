import 'package:notes_app/Todo/domain/repositories/notes_repo.dart';
import 'package:notes_app/utils/usecases/use_case.dart';

class GetNotesUseCase extends UseCase<dynamic,NoParameter>
{
  final NotesRepo _repo;

  GetNotesUseCase(this._repo);
  @override
   call([NoParameter? parameter]) {
    return _repo.getNotes();
  }

}