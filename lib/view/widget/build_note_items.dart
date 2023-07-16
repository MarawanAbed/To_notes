import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/controller/notes_cubit.dart';
import 'package:notes_app/view/widget/custom_note_item.dart';

class BuildNoteItems extends StatelessWidget {
  const BuildNoteItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is DisplayNotesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DisplayNotesSuccess) {
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                var model = state.notes[index];
                return CustomNoteItems(noteModel: model);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: state.notes.length,
            ),
          );
        } else if (state is DisplayNotesError) {
          return const Text('Error loading notes');
        } else {
          return const SizedBox(); // Empty container if the state is not recognized
        }
      },
    );
  }
}
