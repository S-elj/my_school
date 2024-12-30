import 'package:flutter/material.dart';
import '../../screens/student/exercise_screen.dart';
import '/data/models/content_models.dart';

class ExerciseList extends StatelessWidget {
  const ExerciseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) => ExerciseCard(
        exercise: Exercise(
          id: '1',
          title: 'Exercice de mathématiques',
          subject: 'Maths',
          gradeLevel: '6ème',
          type: ExerciseType.qcm,
          questions: [],
        ),
      ),
      itemCount: 10,
    );
  }
}

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const ExerciseCard({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Icon(
          exercise.type == ExerciseType.qcm ? Icons.quiz : Icons.question_answer,
        ),
        title: Text(exercise.title),
        subtitle: Text('${exercise.subject} - ${exercise.gradeLevel}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExerciseScreen(exercise: exercise),
            ),
          );
        },
      ),
    );
  }
}