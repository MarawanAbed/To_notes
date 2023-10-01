import 'package:flutter/material.dart';

Widget myTextField({
  TextEditingController? controller,
  required String title,
  InputBorder? border,
  Color? color,
  double? size,
}) =>  TextField(
      controller: controller,
      style: TextStyle(color: color, fontSize: size),
      decoration: InputDecoration(
        border: border,
        hintText: title,
        hintStyle: TextStyle(color: color, fontSize: size),
      ),
    );
