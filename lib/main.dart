import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_school/presentation/screens/auth/signin_screen.dart';
import 'package:my_school/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '/data/providers/auth_provider.dart';
import '/data/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(AuthRepository()),
        ),
      ],
      child: MaterialApp(
        title: 'MySchool',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            filled: true,
          ),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, authProvider, __) {
        if (authProvider.isLoggedIn) {
          return const HomeScreen();
        }
        return const SignInScreen();
      },
    );
  }
}