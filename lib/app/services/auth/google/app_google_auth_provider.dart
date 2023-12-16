import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_trip_ui/app/services/auth/app_auth_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppGoogleAuthProvider implements AppAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> get isSignedIn async {
    return _auth.currentUser != null;
  }

  @override
  Future<void> signIn() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account == null) {
        // User canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication auth = await account.authentication;
      final googleCredentials = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(googleCredentials);
      final User? user = authResult.user;

      if (user != null) {
        // User signed in successfully
      } else {
        // Handle the case where the user authentication failed
      }
    } catch (e) {
      print("=================================");
      print("Error signing in with Google: $e");
      print("=================================");
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
