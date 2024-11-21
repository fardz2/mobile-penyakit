import 'package:flutter/material.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class GenderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool isSelected; // Add isSelected property

  const GenderButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isSelected = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? customColor : Colors.white, // Highlight if selected
        foregroundColor:
            isSelected ? Colors.white : customColor, // Adjust icon color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: customColor, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      ),
      child: Icon(
        icon,
        size: 28,
      ),
    );
  }
}
