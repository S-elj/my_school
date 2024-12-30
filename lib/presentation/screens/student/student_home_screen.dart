import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/providers/auth_provider.dart';
import '../../widget/student/activity_history.dart';
import '../../widget/student/course_grid.dart';
import '../../widget/student/exercise_list.dart';
import '../../widget/student/live_sessions.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, auth, _) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mes cours'),
            actions: [
              if (auth.isLoggedIn)
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => auth.signOut(),
                ),
            ],
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Cours'),
                Tab(text: 'Exercices'),
                Tab(text: 'Direct'),
                Tab(text: 'Historique'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              CourseGrid(),
              ExerciseList(),
              LiveSessionsList(),
              ActivityHistoryList(),
            ],
          ),
        ),
      );
    });
  }
}
