import 'package:flutter/material.dart';

class ColorItem extends StatelessWidget {
  const ColorItem({
    Key? key,
    required this.color,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final bool isActive;
  final Function(Color) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(color);
      },
      child: CircleAvatar(
        backgroundColor: color,
        radius: 32,
        child: isActive ? const Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}