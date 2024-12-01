import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/icons/svg/download1.svg",
            width: 50,
            height: 50,
          ),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
      content: Text(content, textAlign: TextAlign.center),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: Colors.black), // Border color
                ),
                onPressed: () {
                  Get.back(); // Close the dialog
                  onConfirm(); // Call the confirm action
                },
                child: const Text("YA",
                    style: TextStyle(color: Colors.black)), // Text color
              ),
              const SizedBox(width: 10), // Spacing between buttons
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(color: Colors.black), // Border color
                ),
                onPressed: () {
                  Get.back(); // Close the dialog
                },
                child: const Text("TIDAK",
                    style: TextStyle(color: Colors.black)), // Text color
              ),
            ],
          ),
        ),
      ],
    );
  }
}
