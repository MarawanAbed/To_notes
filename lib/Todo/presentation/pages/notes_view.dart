import 'package:flutter/material.dart';
import 'package:notes_app/Todo/presentation/pages/add_notes.dart';
import 'package:notes_app/Todo/presentation/widgets/build_note_items.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_appbar.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_search_field.dart';

class NotesViewScreen extends StatelessWidget {
  const NotesViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomAppBar(
              icon: Icons.sort,
              text: Text(
                'Notes',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),
            CustomSearchField(),
            SizedBox(height: 10),
            BuildNoteItems(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewNotes()));
        },
        child: const Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }
}
