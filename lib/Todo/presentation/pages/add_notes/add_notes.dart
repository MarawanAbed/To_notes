import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/presentation/bloc/add_notes_cubit.dart';
import 'package:notes_app/Todo/presentation/widgets/colors_note_items.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_arrow_bar.dart';
import 'package:notes_app/utils/components/components.dart';

import 'add_notes_bloc_builder.dart';

class AddNewNotes extends StatefulWidget {
  const AddNewNotes({super.key});

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final ValueNotifier<Color?> selectedColor = ValueNotifier<Color?>(null);

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: CustomArrowBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ValueListenableBuilder<Color?>(
                    valueListenable: selectedColor,
                    builder: (context, value, child) {
                      return BuildColorItem(
                        selectedColor: value,
                        onSelectColor: (color) {
                          selectedColor.value = color;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: titleController,
                    title: 'Title',
                    color: Colors.grey,
                    size: 30,
                    border: InputBorder.none,
                  ),
                  CustomTextField(
                    controller: subTitleController,
                    title: 'Type something here',
                    color: Colors.grey,
                    size: 16,
                    border: InputBorder.none,
                  ),
                  AddNotesBlocListener(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final noteModel = NoteEntity(
            title: titleController.text.isNotEmpty
                ? titleController.text
                : 'No Title',
            subTitle: subTitleController.text.isNotEmpty
                ? subTitleController.text
                : 'No SubTitle',
            date: DateTime.now().toString(),
            color: selectedColor.value?.value ?? const Color(0xFFC0262A).value,
          );
          context.read<AddNotesCubit>().addNote(noteModel);
        },
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
