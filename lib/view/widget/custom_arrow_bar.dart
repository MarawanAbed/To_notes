import 'package:flutter/material.dart';

class CustomArrowBar extends StatelessWidget {
  const CustomArrowBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          padding: const EdgeInsets.all(0),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.grey.shade800.withOpacity(.8),
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
