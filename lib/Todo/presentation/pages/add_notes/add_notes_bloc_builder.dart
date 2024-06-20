import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Todo/presentation/bloc/add_notes_cubit.dart';

class AddNotesBlocListener extends StatelessWidget {
  const AddNotesBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNotesCubit, AddNotesState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Note Added Successfully"),
              ),
            );
            Navigator.pop(context);
          },
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
              ),
            );
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }
}
