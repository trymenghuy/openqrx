// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class User {
//   final String name;
//   final int age;
//   User({
//     required this.name,
//     required this.age,
//   });
// }

// abstract class AuthProvider {
//   Future<User?> signIn();
//   Future<void> signOut();
//   User? getCurrentUser();
// }

// class GoogleAuthProvider implements AuthProvider {
//   @override
//   Future<User?> signIn() async {
//     return null;

//     // Perform Google Sign-In
//     // Return the authenticated user
//   }

//   @override
//   Future<void> signOut() async {
//     // Perform Google Sign-Out
//   }

//   @override
//   User? getCurrentUser() {
//     return null;

//     // Get current user from Google Sign-In
//   }
// }

// class FacebookAuthProvider implements AuthProvider {
//   @override
//   Future<User?> signIn() async {
//     return null;

//     // Perform Facebook Sign-In
//     // Return the authenticated user
//   }

//   @override
//   Future<void> signOut() async {
//     // Perform Facebook Sign-Out
//   }

//   @override
//   User? getCurrentUser() {
//     return null;

//     // Get current user from Facebook Sign-In
//   }
// }

// abstract class AuthenticationManager {
//   Future<User?> signIn();
//   Future<void> signOut();
//   User? getCurrentUser();
// }

// class FirebaseAuthManager extends AuthenticationManager {
//   final AuthProvider authProvider;

//   FirebaseAuthManager(this.authProvider);

//   @override
//   Future<User?> signIn() async {
//     return authProvider.signIn();
//   }

//   @override
//   Future<void> signOut() {
//     return authProvider.signOut();
//   }

//   @override
//   User? getCurrentUser() {
//     return authProvider.getCurrentUser();
//   }
// }

// // Implementations for EmailAuthProvider and PhoneAuthProvider can be similarly defined.
// void main() async {
//   // Creating authentication provider objects
//   final googleAuthProvider = GoogleAuthProvider();
//   final facebookAuthProvider = FacebookAuthProvider();
//   // ...

//   // Creating authentication manager with respective providers
//   FirebaseAuthManager authManager = FirebaseAuthManager(googleAuthProvider);
//   // ...

//   // Sign in with Google
//   final googleUser = await authManager.signIn();

//   // Sign out
//   await authManager.signOut();

//   // Switching to Facebook authentication provider
//   authManager = FirebaseAuthManager(facebookAuthProvider);

//   // Sign in with Facebook
//   final facebookUser = await authManager.signIn();

//   // ...
// }
