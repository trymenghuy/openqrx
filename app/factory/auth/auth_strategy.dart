import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:openqrx/app/util/print.dart';

// Strategy Interface
abstract class AuthenticationStrategy {
  Future<Map<String, dynamic>?> login();
}

class PhoneAuthenticationStrategy implements AuthenticationStrategy {
  final String verificationId;
  final String smsCode;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  PhoneAuthenticationStrategy(this.verificationId, this.smsCode);

  @override
  Future<Map<String, dynamic>?> login() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        smsCode: smsCode, verificationId: verificationId);
    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return {'userCredential': userCredential.user?.uid};
  }

  // @override
  // Future<Map<String, dynamic>?> login() async {
  //   try {
  //     Completer<Map<String, dynamic>?> completer =
  //         Completer<Map<String, dynamic>?>();

  //     _firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: phone,
  //       forceResendingToken: forceResendingToken,
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // ANDROID ONLY!
  //         await _firebaseAuth.signInWithCredential(credential);
  //         completer.complete({'success': true});
  //       },
  //       verificationFailed: (FirebaseAuthException e) {
  //         if (e.code == 'invalid-phone-number') {
  //           print('The provided phone number is not valid.');
  //         }
  //         completer.complete({'success': false, 'error': e.message});
  //       },
  //       codeSent: (String verificationId, int? resendToken) async {
  //         String smsCode = 'xxxx';
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //             verificationId: verificationId, smsCode: smsCode);
  //         // Sign the user in (or link) with the credential
  //         await _firebaseAuth.signInWithCredential(credential);
  //         completer.complete({'success': true});
  //       },
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         completer
  //             .complete({'success': false, 'error': 'Verification timeout.'});
  //       },
  //     );
  //     return completer.future;
  //   } on FirebaseAuthException catch (e) {
  //     // Handle error
  //     xPrint('Phone sign-in error: $e');
  //     return null;
  //   }
  // }
}

// Concrete Strategy: Email/Password Authentication
class EmailPasswordAuthenticationStrategy implements AuthenticationStrategy {
  final String email;
  final String password;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  EmailPasswordAuthenticationStrategy(this.email, this.password);

  @override
  Future<Map<String, dynamic>?> login() async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return {'userCredential': userCredential.user?.uid};
    } catch (e) {
      // Handle error
      xPrint('Email/password sign-in error: $e');
      return null;
    }
  }
}

// Concrete Strategy: Facebook Authentication
class FacebookAuthenticationStrategy implements AuthenticationStrategy {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Map<String, dynamic>?> login() async {
    try {
      final facebookAuthProvider = FacebookAuthProvider();
      final UserCredential userCredential =
          await _firebaseAuth.signInWithPopup(facebookAuthProvider);
      return {'userCredential': userCredential.user?.uid};
    } catch (e) {
      // Handle error
      xPrint('Facebook sign-in error: $e');
      return null;
    }
  }
}

// Concrete Strategy: Google Authentication
class GoogleAuthenticationStrategy implements AuthenticationStrategy {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Map<String, dynamic>?> login() async {
    try {
      final googleAuthProvider = GoogleAuthProvider();
      final UserCredential userCredential =
          await _firebaseAuth.signInWithPopup(googleAuthProvider);

      return {'userCredential': userCredential.user?.uid};
    } catch (e) {
      // Handle error
      xPrint('Google sign-in error: $e');
      return null;
    }
  }
}

// Context
class AuthenticationContext {
  AuthenticationStrategy? _authenticationStrategy;

  void setAuthenticationStrategy(AuthenticationStrategy strategy) {
    _authenticationStrategy = strategy;
  }

  Future<Map<String, dynamic>?> signIn() {
    if (_authenticationStrategy == null) {
      throw Exception('No authentication strategy set.');
    }
    return _authenticationStrategy!.login();
  }
}

// void main() async {
//   final authenticationContext = AuthenticationContext();

//   // Set the desired authentication strategy dynamically
//   authenticationContext.setAuthenticationStrategy(
//     EmailPasswordAuthenticationStrategy('example@email.com', 'password'),
//   );

//   // Perform the authentication
//   final userCredential = await authenticationContext.signIn();
//   if (userCredential != null) {
//     print('Signed in: $userCredential');
//   } else {
//     print('Sign-in failed.');
//   }
// }
