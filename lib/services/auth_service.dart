
import 'package:firebase_auth/firebase_auth.dart';

// Conditional import for Google Sign-In
import 'auth_service_stub.dart'
    if (dart.library.io) 'auth_service_io.dart' as google_sign_in_impl;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Current user
  User? get currentUser => _auth.currentUser;

  // Sign in with Email/Password
  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Sign up with Email/Password
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    return await google_sign_in_impl.signInWithGoogle(_auth);
  }

  // Sign Out
  Future<void> signOut() async {
    await google_sign_in_impl.signOutGoogle();
    await _auth.signOut();
  }
}
