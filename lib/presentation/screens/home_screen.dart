import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/providers/auth_provider.dart';
import '/presentation/screens/student/student_home_screen.dart';
import '/data/models/auth_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        final userType = auth.currentUserType;

        // Redirection selon le type d'utilisateur
        if (userType == UserType.student) {
          return const StudentHomeScreen();
        }

        // Interface par défaut pour les autres types d'utilisateurs
        return Scaffold(
          appBar: AppBar(
            title: const Text('School App'),
            actions: [
              if (auth.isLoggedIn)
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => auth.signOut(),
                ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userType == UserType.parent
                      ? 'Interface parent en cours de développement'
                      : 'Type d\'utilisateur non reconnu',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                if (auth.isLoggedIn)
                  ElevatedButton.icon(
                    onPressed: () => auth.signOut(),
                    icon: const Icon(Icons.logout),
                    label: const Text('Se déconnecter'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}