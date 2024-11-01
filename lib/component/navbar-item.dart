import 'package:flutter/material.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class NavbarItem extends StatelessWidget {
  final bool status;
  final String label;
  final String active;
  final String inactive;

  const NavbarItem(
      {super.key,
      required this.status,
      required this.label,
      required this.active,
      required this.inactive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: customColor3,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Allow the Row to take minimum space
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
            width: 40,
            child: Image.asset(
              status ? active : inactive,
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: status
                ? Padding(
                    padding: const EdgeInsets.only(
                        right: 15), // Add padding to the text
                    child: Text(
                      label,
                      style: const TextStyle(
                          color: Colors.white), // Adjust text size if necessary
                    ),
                  )
                : const SizedBox(), // Placeholder widget if condition is false
          ),
        ],
      ),
    );
  }
}
