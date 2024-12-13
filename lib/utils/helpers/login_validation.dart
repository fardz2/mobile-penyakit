class LoginValidation {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Masukkan email yang valid';
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong';
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

  // Validasi untuk phone number
  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    final phoneRegex = RegExp(r'^\+?1?\d{9,15}$'); // format nomor telepon
    if (!phoneRegex.hasMatch(value)) {
      return 'Masukkan nomor telepon yang valid';
    }
    return null;
  }

  // Validasi tujuan permohonan (dianggap bebas teks)
  static String? tujuanPermohonan(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tujuan permohonan tidak boleh kosong';
    }
    return null;
  }

  static String? instiusi(String? value) {
    if (value == null || value.isEmpty) {
      return 'Institusi tidak boleh kosong';
    }
    return null;
  }

  // Validasi untuk konfirmasi password
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (value != password) {
      return 'Password dan konfirmasi password harus sama';
    }
    return null;
  }
}
