import 'package:notes_app/Todo/domain/entities/notes_entity.dart';

abstract class NotesRepo
{
  addNote(NoteEntity note);
  getNotes();
}