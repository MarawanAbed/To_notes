import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.title, required this.color, required this.size, required this.border});
  final TextEditingController controller;
  final String title;
  final Color color;
  final double size;
  final InputBorder border;
  @override
  Widget build(BuildContext context) {
    controller.text = title; // Set the controller's text to the title

    return  TextField(
      maxLines: null,
      controller: controller,
      style: TextStyle(color: color, fontSize: size),
      decoration: InputDecoration(
        border: border,
        hintStyle: TextStyle(color: color, fontSize: size,),
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
