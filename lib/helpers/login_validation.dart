// Validation for Login
class LoginValidation {
  // Validasi untuk email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    // Regex untuk validasi format email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Masukkan email yang valid';
    }
    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username tidak boleh kosong';
    }

    return null;
  }

  // Validasi untuk password
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }
}
