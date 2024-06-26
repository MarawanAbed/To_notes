import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/Todo/presentation/bloc/get_notes/get_notes_cubit.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? text;
  final IconData icon;

  const CustomAppBar({
    Key? key,
    this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        text!,
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            context.read<GetNotesCubit>().sortNotes();
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade800.withOpacity(.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
