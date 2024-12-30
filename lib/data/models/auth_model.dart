import 'package:firebase_auth/firebase_auth.dart';


enum UserType { parent, student }

class AuthModel {
  final User? user;
  final UserType? userType;
  final String? firstName;
  final String? lastName;
  final String? email;
  final List<StudentInfo>? students; // Pour les parents
  final String? gradeLevel; // Pour les étudiants
  final String? subscriptionType;
  final String? trainingMode;

  const AuthModel({
    this.user,
    this.userType,
    this.firstName,
    this.lastName,
    this.email,
    this.students,
    this.gradeLevel,
    this.subscriptionType,
    this.trainingMode,
  });

  AuthModel copyWith({
    User? user,
    UserType? userType,
    String? firstName,
    String? lastName,
    String? email,
    List<StudentInfo>? students,
    String? gradeLevel,
    String? subscriptionType,
    String? trainingMode,
  }) {
    return AuthModel(
      user: user ?? this.user,
      userType: userType ?? this.userType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      students: students ?? this.students,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      trainingMode: trainingMode ?? this.trainingMode,
    );
  }
}

class StudentInfo {
  final String firstName;
  final String lastName;
  final String relationship;
  final String gradeLevel;

  StudentInfo({
    required this.firstName,
    required this.lastName,
    required this.relationship,
    required this.gradeLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'relationship': relationship,
      'gradeLevel': gradeLevel,
    };
  }

  factory StudentInfo.fromMap(Map<String, dynamic> map) {
    return StudentInfo(
      firstName: map['firstName'],
      lastName: map['lastName'],
      relationship: map['relationship'],
      gradeLevel: map['gradeLevel'],
    );
  }
}