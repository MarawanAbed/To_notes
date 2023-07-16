import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/controller/notes_cubit.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? text;
  final IconData icon;
  const CustomAppBar({
    super.key,
    this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text!,
        IconButton(
            onPressed: () {
              final cubit = context.read<NotesCubit>();
              cubit.sortNotes();
            },
            padding: const EdgeInsets.all(0),
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey.shade800.withOpacity(.8),
                  borderRadius: BorderRadius.circular(10)),
              child:Icon(
                icon,
                color: Colors.white,
              ),
            ),
        ),
      ],
    );
  }
}