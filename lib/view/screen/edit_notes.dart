import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/components/components.dart';
import 'package:notes_app/controller/notes_cubit.dart';
import 'package:notes_app/models/notes_model.dart';
import 'package:notes_app/view/widget/colors_note_items.dart';
import 'package:notes_app/view/widget/custom_arrow_bar.dart';

class EditNote extends StatelessWidget {
  final NoteModel noteModel;

  const EditNote({super.key, required this.noteModel});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<NotesCubit>(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Column(
              children: [
                const CustomArrowBar(),
                BuildColorItem(
                  onSelectColor: cubit.selectColor,
                  selectedColor: cubit.selectedColor,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      myTextField(
                        controller: cubit.titleController,
                        title: noteModel.title!,
                        color: Colors.grey,
                        size: 30,
                        border: InputBorder.none,
                      ),
                      myTextField(
                        controller: cubit.subTitleController,
                        title: noteModel.subTitle!,
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
            onPressed: () {
              cubit.showConfirmationDialog(() {
                noteModel.title = cubit.titleController.text ?? noteModel.title;
                noteModel.subTitle = cubit.subTitleController.text ?? noteModel.subTitle;
                noteModel.color = cubit.selectedColor != null
                    ? cubit.selectedColor!.value
                    : noteModel.color;
                noteModel.save();
                Navigator.pop(context);
                cubit.getNotes();
              }, context
              );
            },
            backgroundColor: Colors.grey.shade800,
            child: const Icon(Icons.check),
          ),
    );
  }
}
