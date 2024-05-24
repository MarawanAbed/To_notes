import 'package:flutter/material.dart';

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
