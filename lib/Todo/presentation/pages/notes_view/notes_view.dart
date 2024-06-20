import 'package:flutter/material.dart';
import 'package:notes_app/Todo/presentation/widgets/build_note_items.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_appbar.dart';
import 'package:notes_app/Todo/presentation/widgets/custom_search_field.dart';
import 'package:notes_app/utils/routes/routes.dart';

class NotesViewScreen extends StatelessWidget {
  const NotesViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
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
                  SizedBox(height: 20),
                ],
              ),
            ),
            SliverFillRemaining(
              child: BuildNoteItems(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addNotes);
        },
        child: const Icon(
          Icons.add,
          size: 38,
          color: Colors.white,
        ),
      ),
    );
  }
}
