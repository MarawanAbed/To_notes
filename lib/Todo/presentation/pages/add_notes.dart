import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Todo/presentation/manager/notes_cubit.dart';
import 'package:notes_app/Todo/presentation/widgets/colors_note_items.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_arrow_bar.dart';
import 'package:notes_app/utils/components/components.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';

class AddNewNotes extends StatefulWidget {
  const AddNewNotes({super.key});

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  Color? selectedColor;

  @override
  void dispose() {
    titleController.dispose();
    subTitleController.dispose();
    super.dispose();
  }

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
        final cubit = NotesCubit.get(context);
        return BlurryModalProgressHUD(
          color: Colors.orange,
          inAsyncCall: state is AddNotesLoading ? true : false,
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
                          selectedColor: selectedColor,
                          onSelectColor: (color) {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        myTextField(
                          controller: titleController,
                          title: 'Title',
                          color: Colors.grey,
                          size: 30,
                          border: InputBorder.none,
                        ),
                        myTextField(
                          controller: subTitleController,
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
              onPressed: () async {
                final noteModel = NoteEntity(
                  title: titleController.text.isNotEmpty ? titleController.text : 'No Title',
                  subTitle: subTitleController.text.isNotEmpty ? subTitleController.text : 'No SubTitle',
                  date: DateTime.now().toString(),
                  color: selectedColor?.value ?? const Color(0xFFC0262A).value,
                );
                cubit.addNote(noteModel);
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
