import 'package:notes_app/Todo/domain/entities/notes_entity.dart';

abstract class LocalDataSource
{
  addNote(NoteEntity note);
  getNotes();
}