import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text("Batal"),
        ),
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
            onConfirm(); // Call the confirm action
          },
          child: const Text("Unduh"),
        ),
      ],
    );
  }
}
