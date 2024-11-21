import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class AboutWidget extends StatelessWidget {
  final bool status;
  final String label;
  final String active;

  const AboutWidget({
    super.key,
    required this.status,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Allow the Row to take minimum space
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 40,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: customColor3,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(
              width: 10,
              height: 10,
              active,
              colorFilter: status
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : const ColorFilter.mode(customColor4, BlendMode.srcIn),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: status
                ? Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 10), // Add padding to the text
                    child: Text(
                      label,
                      style: const TextStyle(), // Adjust text size if necessary
                    ),
                  )
                : const SizedBox(), // Placeholder widget if condition is false
          ),
        ],
      ),
    );
  }
}
