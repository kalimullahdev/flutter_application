import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String dateOfBirth;
  final String programmingLanguage;
  final String hobbies;
  final String gender;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.dateOfBirth,
    required this.programmingLanguage,
    required this.hobbies,
    required this.gender,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? dateOfBirth,
    String? programmingLanguage,
    String? hobbies,
    String? gender,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      programmingLanguage: programmingLanguage ?? this.programmingLanguage,
      hobbies: hobbies ?? this.hobbies,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'programmingLanguage': programmingLanguage,
      'hobbies': hobbies,
      'gender': gender,
    };
  }

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, password: $password, dateOfBirth: $dateOfBirth, programmingLanguage: $programmingLanguage, hobbies: $hobbies, gender: $gender)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.dateOfBirth == dateOfBirth &&
        other.programmingLanguage == programmingLanguage &&
        other.hobbies == hobbies &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        dateOfBirth.hashCode ^
        programmingLanguage.hashCode ^
        hobbies.hashCode ^
        gender.hashCode;
  }
}
