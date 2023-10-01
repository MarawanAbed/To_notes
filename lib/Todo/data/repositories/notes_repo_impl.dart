import 'package:notes_app/Todo/data/data_sources/local_data_source.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/domain/repositories/notes_repo.dart';

class NotesRepoImpl implements NotesRepo {
  final LocalDataSource localDataSource;

  NotesRepoImpl(this.localDataSource);

  @override
  addNote(NoteEntity note) {
    return localDataSource.addNote(note);
  }

  @override
  getNotes() {
    return localDataSource.getNotes();
  }
}
