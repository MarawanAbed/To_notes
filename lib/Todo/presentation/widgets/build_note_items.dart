import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Todo/presentation/manager/notes_cubit.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_note_item.dart';

class BuildNoteItems extends StatelessWidget {
  const BuildNoteItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is DisplayNotesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error loading notes: ${state.message}'),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is DisplayNotesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DisplayNotesSuccess) {
          if (state.notes.isEmpty) {
            // Show a message when there are no notes to display.
            return const Center(
              child: Text('No notes available.'),
            );
          }
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
        } else {
          return const SizedBox(); // Empty container if the state is not recognized
        }
      },
    );
  }
}
