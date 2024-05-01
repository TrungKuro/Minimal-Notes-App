import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  const NoteSettings({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Edit Button
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            onEditPressed!();
          },
          icon: const Icon(Icons.edit),
        ),
        // Delete Button
        IconButton(
          onPressed: () {
            Navigator.pop(context);
            onDeletePressed!();
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }
}
