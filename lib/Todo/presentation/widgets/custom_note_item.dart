import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/Todo/domain/entities/notes_entity.dart';
import 'package:notes_app/Todo/presentation/bloc/get_notes_cubit.dart';
import 'package:notes_app/utils/routes.dart';

class CustomNoteItems extends StatelessWidget {
  const CustomNoteItems({
    Key? key,
    required this.noteModel,
  }) : super(key: key);

  final NoteEntity noteModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.editNotes, arguments: noteModel);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color(noteModel.color!),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      noteModel.title!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showPlatformDialog(
                        context: context,
                        builder: (_) => BasicDialogAlert(
                          title: const Text('Delete Note'),
                          content: const Text(
                              'Are you sure you want to delete this note?'),
                          actions: <Widget>[
                            BasicDialogAction(
                              title: const Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            BasicDialogAction(
                              title: const Text('Delete'),
                              onPressed: () {
                                noteModel.delete();
                                context.read<GetNotesCubit>().getNotes();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.grey.shade800),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      noteModel.subTitle!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(noteModel.date))}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//                  Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             noteModel.subTitle!,
//                             style:  TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal,
//                               color: Colors.grey.shade800,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             'Date: ${DateFormat('dd MMMM yyyy').format(DateTime.parse(noteModel.date))}',
//                             style: const TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//
//                         ],
//                       ),
//                     ],
//                   ),
