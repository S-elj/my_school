import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/data/models/auth_model.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<Map<String, dynamic>> getUserData(String uid) async {
    final docSnapshot = await _firestore.collection('users').doc(uid).get();
    if (!docSnapshot.exists) {
      throw Exception('Utilisateur non trouvé');
    }
    return docSnapshot.data()!;
  }

  Future<void> registerParent({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required List<StudentInfo> students,
    required String subscriptionType,
    required String trainingMode,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'userType': 'parent',
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'students': students.map((s) => s.toMap()).toList(),
        'subscriptionType': subscriptionType,
        'trainingMode': trainingMode,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Créer des comptes pour chaque élève
      for (var student in students) {
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .collection('students')
            .add(student.toMap());
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'inscription: $e');
    }
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
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'userType': 'student',
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'gradeLevel': gradeLevel,
        'subscriptionType': subscriptionType,
        'trainingMode': trainingMode,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Erreur lors de l\'inscription: $e');
    }
  }




  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}