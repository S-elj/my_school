import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/home_screen.dart';
import '/data/providers/auth_provider.dart';
import 'common_form_fields.dart';

class StudentSignUpForm extends StatefulWidget {
  const StudentSignUpForm({super.key});

  @override
  State<StudentSignUpForm> createState() => _StudentSignUpFormState();
}

class _StudentSignUpFormState extends State<StudentSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String _gradeLevel = '6ème';
  String _selectedSubscription = '1 cours par année scolaire';
  String _selectedTrainingMode = 'Formule progression';
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.registerStudent(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        gradeLevel: _gradeLevel,
        subscriptionType: _selectedSubscription,
        trainingMode: _selectedTrainingMode,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compte créé avec succès!')),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CommonFormFields(
              emailController: _emailController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
            ),
            const SizedBox(height: 24),

            // Niveau scolaire
            DropdownButtonFormField<String>(
              value: _gradeLevel,
              decoration: const InputDecoration(
                labelText: 'Niveau scolaire',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: '6ème', child: Text('6ème')),
                DropdownMenuItem(value: '5ème', child: Text('5ème')),
                DropdownMenuItem(value: '4ème', child: Text('4ème')),
                DropdownMenuItem(value: '3ème', child: Text('3ème')),
                DropdownMenuItem(value: '2nde', child: Text('2nde')),
                DropdownMenuItem(value: '1ère', child: Text('1ère')),
                DropdownMenuItem(value: 'Terminale', child: Text('Terminale')),
              ],
              onChanged: (value) {
                setState(() {
                  _gradeLevel = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            // Type d'abonnement
            DropdownButtonFormField<String>(
              value: _selectedSubscription,
              decoration: const InputDecoration(
                labelText: 'Type d\'abonnement',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: '1 cours par année scolaire',
                  child: Text('1 cours par année scolaire'),
                ),
                DropdownMenuItem(
                  value: '2 cours par année scolaire',
                  child: Text('2 cours par année scolaire'),
                ),
                DropdownMenuItem(
                  value: 'Tous les cours',
                  child: Text('Tous les cours'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSubscription = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            // Mode de formation
            DropdownButtonFormField<String>(
              value: _selectedTrainingMode,
              decoration: const InputDecoration(
                labelText: 'Mode de formation',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Formule progression',
                  child: Text('Formule progression'),
                ),
                DropdownMenuItem(
                  value: 'Formule accompagnement',
                  child: Text('Formule accompagnement'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedTrainingMode = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}