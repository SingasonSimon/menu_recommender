
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> signInWithGoogle(FirebaseAuth auth) async {
  throw UnimplementedError('Google Sign-In is not supported on this platform.');
}

Future<void> signOutGoogle() async {
  // No-op for unsupported platforms
}

