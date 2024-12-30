// student_signup_screen.dart
import 'package:flutter/material.dart';
import '../../widget/auth/student_signup_form.dart';

class StudentSignUpScreen extends StatelessWidget {
  const StudentSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription Élève'),
      ),
      body: const SingleChildScrollView(
        child: StudentSignUpForm(),
      ),
    );
  }
}