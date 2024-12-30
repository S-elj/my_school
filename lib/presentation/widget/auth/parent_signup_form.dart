import 'package:flutter/material.dart';
import 'package:my_school/presentation/widget/auth/student_info_dialog.dart';
import 'package:provider/provider.dart';
import '../../screens/home_screen.dart';
import '/data/models/auth_model.dart';
import '/data/providers/auth_provider.dart';
import 'common_form_fields.dart';

class ParentSignUpForm extends StatefulWidget {
  const ParentSignUpForm({super.key});

  @override
  State<ParentSignUpForm> createState() => _ParentSignUpFormState();
}

class _ParentSignUpFormState extends State<ParentSignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  List<StudentInfo> students = [];
  String selectedSubscription = '1 cours par année scolaire';
  String selectedTrainingMode = 'Formule progression';
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

  void _addStudent() {
    showDialog(
      context: context,
      builder: (context) => StudentInfoDialog(
        onAdd: (studentInfo) {
          setState(() {
            students.add(studentInfo);
          });
        },
      ),
    );
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (students.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ajoutez au moins un élève')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.registerParent(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        students: students,
        subscriptionType: selectedSubscription,
        trainingMode: selectedTrainingMode,
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

            // Liste des élèves
            ...students.map((student) => ListTile(
              title: Text('${student.firstName} ${student.lastName}'),
              subtitle: Text('${student.relationship} - ${student.gradeLevel}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    students.remove(student);
                  });
                },
              ),
            )).toList(),

            ElevatedButton.icon(
              onPressed: _addStudent,
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un élève'),
            ),

            const SizedBox(height: 16),

            // Choix de l'abonnement
            DropdownButtonFormField<String>(
              value: selectedSubscription,
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
                  selectedSubscription = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            // Mode de formation
            DropdownButtonFormField<String>(
              value: selectedTrainingMode,
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
                  selectedTrainingMode = value!;
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