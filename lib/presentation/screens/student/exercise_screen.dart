import 'package:flutter/material.dart';
import '/data/models/content_models.dart';

class ExerciseScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseScreen({super.key, required this.exercise});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, String> _answers = {};

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.exercise.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.title),
      ),
      body: Column(
        children: [
          // Barre de progression
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / widget.exercise.questions.length,
          ),

          // Question
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1}/${widget.exercise.questions.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentQuestion.question,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 24),
                  if (widget.exercise.type == ExerciseType.qcm)
                    ...currentQuestion.options.map((option) => RadioListTile(
                      title: Text(option),
                      value: option,
                      groupValue: _answers[_currentQuestionIndex],
                      onChanged: (value) {
                        setState(() {
                          _answers[_currentQuestionIndex] = value!;
                        });
                      },
                    ))
                  else
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Votre réponse',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        _answers[_currentQuestionIndex] = value;
                      },
                    ),
                ],
              ),
            ),
          ),

          // Navigation
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
                      });
                    },
                    child: const Text('Précédent'),
                  )
                else
                  const SizedBox.shrink(),
                ElevatedButton(
                  onPressed: () {
                    if (_currentQuestionIndex < widget.exercise.questions.length - 1) {
                      setState(() {
                        _currentQuestionIndex++;
                      });
                    } else {
                      // Soumettre l'exercice et revenir à l'écran précédent
                      // TODO: Ajoutez ici la logique de soumission
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    _currentQuestionIndex < widget.exercise.questions.length - 1
                        ? 'Suivant'
                        : 'Terminer',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}