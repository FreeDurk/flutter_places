// import 'package:firebase_auth/firebase_auth.dart';

abstract class AppAuthProvider {
  Future<void> signIn();
  Future<void> signOut();
  Future<bool> get isSignedIn;
}
