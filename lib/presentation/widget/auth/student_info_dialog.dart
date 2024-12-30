import 'package:flutter/material.dart';
import '/data/models/auth_model.dart';

class StudentInfoDialog extends StatefulWidget {
  final void Function(StudentInfo studentInfo) onAdd;

  const StudentInfoDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<StudentInfoDialog> createState() => _StudentInfoDialogState();
}

class _StudentInfoDialogState extends State<StudentInfoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  String _relationship = 'Parent';
  String _gradeLevel = '6ème';

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un élève'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le prénom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _relationship,
                decoration: const InputDecoration(
                  labelText: 'Lien de parenté',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Parent', child: Text('Parent')),
                  DropdownMenuItem(value: 'Tuteur', child: Text('Tuteur')),
                  DropdownMenuItem(value: 'Autre', child: Text('Autre')),
                ],
                onChanged: (value) {
                  setState(() {
                    _relationship = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
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
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onAdd(
                StudentInfo(
                  firstName: _firstNameController.text,
                  lastName: _lastNameController.text,
                  relationship: _relationship,
                  gradeLevel: _gradeLevel,
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('Ajouter'),
        ),
      ],
    );
  }
}