class User {
  final int id;
  final String name;
  final String email;
  final String institution;
  final String gender;
  final String phone;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.institution,
    required this.gender,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      institution: json['institution'],
      gender: json['gender'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'institution': institution,
      'gender': gender,
      'phone': phone,
    };
  }
}
