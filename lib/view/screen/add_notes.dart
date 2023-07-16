import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/components/components.dart';
import 'package:notes_app/controller/notes_cubit.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/view/widget/colors_note_items.dart';
import 'package:notes_app/view/widget/custom_arrow_bar.dart';

class AddNewNotes extends StatelessWidget {
  const AddNewNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesCubit, NotesState>(
      listener: (context, state) {
        if (state is AddNotesSuccess) {
          NotesCubit.get(context).getNotes();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = NotesCubit.get(context);
        return BlurryModalProgressHUD(
          color: Colors.orange,
          inAsyncCall: state is AddNotesLoading ? true:false,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
              child: Column(
                children: [
                  const CustomArrowBar(),
                  Expanded(
                    child: ListView(
                      children: [
                        BuildColorItem(
                          selectedColor: cubit.selectedColor,
                          onSelectColor: cubit.selectColor,
                        ),
                        myTextField(
                          controller: cubit.titleController,
                          title: 'Title',
                          color: Colors.grey,
                          size: 30,
                          border: InputBorder.none,
                        ),
                        myTextField(
                          controller: cubit.subTitleController,
                          title: 'Type something here',
                          color: Colors.grey,
                          size: 16,
                          border: InputBorder.none,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async{
                var noteModel = NoteModel(
                    title: cubit.titleController.text,
                    subTitle: cubit.subTitleController.text,
                    date: DateTime.now().toString(),
                    color: cubit.selectedColor?.value ?? Colors.red.value,
                );
                await cubit.addNote(noteModel);
              },
              backgroundColor: Colors.grey.shade800,
              child: const Icon(Icons.save),
            ),
          ),
        );
      },
    );
  }
}
