import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Todo/data/data_sources/local_data_source.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/utils/constant/string.dart';

class LocalDataSourceImpl extends LocalDataSource {
  @override
  addNote(NoteEntity note) {
    var box = Hive.box<NoteEntity>(AppStrings.myBox);
    box.add(note);
  }

  @override
  getNotes() {
    var box = Hive.box<NoteEntity>(AppStrings.myBox);
    return box.values.toList();
  }
}
