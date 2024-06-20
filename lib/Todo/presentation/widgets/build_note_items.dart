import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/presentation/bloc/get_notes_cubit.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_note_item.dart';
import 'package:notes_app/utils/constant/constant.dart';

class BuildNoteItems extends StatefulWidget {
  const BuildNoteItems({
    super.key,
  });

  @override
  State<BuildNoteItems> createState() => _BuildNoteItemsState();
}

class _BuildNoteItemsState extends State<BuildNoteItems> {
  late final Box<NoteEntity> noteBox;

  @override
  void initState() {
    noteBox = Hive.box<NoteEntity>(myBox);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: noteBox.listenable(),
      builder: (BuildContext context, Box<NoteEntity> value, Widget? child) {
        return BlocBuilder<GetNotesCubit, GetNotesState>(
          buildWhen: (previous, current) {
            return current is Loading || current is Success || current is Error;
          },
          builder: (BuildContext context, state) {
            return state.when(
              initial: () {
                context.read<GetNotesCubit>().getNotes();
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              success: (notes) {
                return notes.isEmpty
                    ? Center(
                        child: Text(
                          "No Notes Yet",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var model = notes[index];
                          return CustomNoteItems(noteModel: model);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: notes.length,
                      );
              },
              error: (message) => Center(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

//ValueListenableBuilder(
//       valueListenable: noteBox.listenable(),
//       builder: (context, Box<NoteEntity> box, _) {
//         var notes = box.values.toList();
//         return notes.isEmpty
//             ? Expanded(
//                 child: Center(
//                 child: Text(
//                   "No Notes Yet",
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ))
//             : ListView.separated(
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   var model = notes[index];
//                   return CustomNoteItems(noteModel: model);
//                 },
//                 separatorBuilder: (context, index) {
//                   return const SizedBox(
//                     height: 10,
//                   );
//                 },
//                 itemCount: notes.length,
//               );
//       },
//     );
