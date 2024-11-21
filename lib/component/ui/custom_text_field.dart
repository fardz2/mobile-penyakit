import 'package:flutter/material.dart';
import 'package:heartrate_database_u_i/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget prefixIcon;
  final bool isPassword;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onPressed;
  final bool isNumeric; // Untuk menentukan apakah input hanya angka

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.obscureText = true,
    this.onPressed,
    this.isNumeric = false, // Defaultnya tidak hanya angka
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: isNumeric
          ? TextInputType.number
          : TextInputType.text, // Menyesuaikan keyboard untuk angka atau teks
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  (obscureText ?? false)
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: onPressed,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: customColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: customColor),
        ),
      ),
      obscureText: isPassword && (obscureText ?? false),
      validator: validator,
    );
  }
}
