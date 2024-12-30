import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '/data/repositories/auth_repository.dart';
import '/data/models/auth_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _repository;
  Error? error;
  UserType? _userType;  // Cache du type d'utilisateur

  AuthProvider(this._repository) {
    _repository.authStateChanges.listen((user) async {
      if (user != null) {
        // Charger le type d'utilisateur dès la connexion
        try {
          final userData = await _repository.getUserData(user.uid);
          _userType = userData['userType'] == 'student' ? UserType.student : UserType.parent;
        } catch (e) {
          error = e as Error;
        }
      } else {
        _userType = null;
      }
      notifyListeners();
    }, onError: (error) {
      this.error = error;
      notifyListeners();
    });
  }

  UserType? get currentUserType => _userType;


  User? get currentUser => _repository.currentUser;

  bool get isLoggedIn => _repository.currentUser != null;


  Future<void> registerParent({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required List<StudentInfo> students,
    required String subscriptionType,
    required String trainingMode,
  }) async {
    await _repository.registerParent(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      students: students,
      subscriptionType: subscriptionType,
      trainingMode: trainingMode,
    );
  }

  Future<void> registerStudent({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String gradeLevel,
    required String subscriptionType,
    required String trainingMode,
  }) async {
    await _repository.registerStudent(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      gradeLevel: gradeLevel,
      subscriptionType: subscriptionType,
      trainingMode: trainingMode,
    );
  }

  Future<void> signOut() async {
    await _repository.signOut();
    _userType = null;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    await _repository.signIn(email, password);
    if (_repository.currentUser != null) {
      final userData = await _repository.getUserData(_repository.currentUser!.uid);
      _userType = userData['userType'] == 'student' ? UserType.student : UserType.parent;
      notifyListeners();
    }
  }

  Future<void> resetPassword(String email) async {
    await _repository.sendPasswordResetEmail(email);
  }
}