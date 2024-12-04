import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuthService? _instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Private constructor
  FirebaseAuthService._();

  static FirebaseAuthService get instance {
    _instance ??= FirebaseAuthService._();
    return _instance!;
  }

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      // Handle error
      print('Sign in error: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
