import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/presentation/widgets/colors_note_items.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_arrow_bar.dart';
import 'package:notes_app/utils/components/components.dart';

class EditNote extends StatefulWidget {
  const EditNote({
    Key? key,
  }) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController titleController;
  late TextEditingController subTitleController;
  late NoteEntity noteModel;
  final ValueNotifier<Color?> selectedColor = ValueNotifier<Color?>(null);

  @override
  void didChangeDependencies() {
    noteModel = ModalRoute.of(context)!.settings.arguments as NoteEntity;
    titleController = TextEditingController(text: noteModel.title);
    subTitleController = TextEditingController(text: noteModel.subTitle);
    super.didChangeDependencies();
  }

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
        padding: const EdgeInsets.fromLTRB(16, 30, 0, 0),
        child: ListView(
          shrinkWrap: true,
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
            CustomTextField(
              controller: titleController,
              color: Colors.grey,
              title: noteModel.title ?? '',
              size: 30,
              border: InputBorder.none,
            ),
            CustomTextField(
              controller: subTitleController,
              title: noteModel.subTitle ?? '',
              color: Colors.grey,
              size: 16,
              border: InputBorder.none,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (titleController.text.trim() == noteModel.title &&
              subTitleController.text.trim() == noteModel.subTitle &&
              selectedColor.value == null) {
            Navigator.pop(context);
            return;
          } else {
            final newTitle = titleController.text.trim();
            final newSubTitle = subTitleController.text.trim();
            if (newTitle.isNotEmpty) {
              noteModel.title = newTitle;
            }
            if (newSubTitle.isNotEmpty) {
              noteModel.subTitle = newSubTitle;
            }
            noteModel.color = selectedColor.value?.value ?? noteModel.color;
            await noteModel.save();
            Navigator.pop(context);
          }
        },
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}

Future<void> showConfirmationDialog(Function() onConfirm, context) async {
  final confirmed = await showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: const Text('Edit Note'),
      content: const Text('Are you sure you want to edit this note?'),
      actions: <Widget>[
        BasicDialogAction(
          title: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        BasicDialogAction(
          title: const Text('Edit'),
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
        ),
      ],
    ),
  );
  if (confirmed ?? false) {
    onConfirm();
  }
}
