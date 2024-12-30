import 'package:flutter/material.dart';
import '../../widget/auth/parent_signup_form.dart';

class ParentSignUpScreen extends StatelessWidget {
  const ParentSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription Parent'),
      ),
      body: const SingleChildScrollView(
        child: ParentSignUpForm(),
      ),
    );
  }
}