import 'package:flutter/material.dart';
import 'package:notes_app/utils/constant/constant.dart';
import 'package:notes_app/Todo/presentation/widgets/build_item_color.dart';

class BuildColorItem extends StatelessWidget {
  const BuildColorItem({
    Key? key,
    required this.selectedColor,
    required this.onSelectColor,
  }) : super(key: key);

  final Color? selectedColor;
  final Function(Color) onSelectColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32 * 2, // 2*32
      child: ListView.separated(
        itemCount: backgroundColors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final color = backgroundColors[index];
          return ColorItem(
            color: color,
            isActive: color == selectedColor,
            onTap: onSelectColor,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 10,
          );
        },
      ),
    );
  }
}
