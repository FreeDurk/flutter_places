import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_trip_ui/app/services/auth/app_auth_provider.dart';

class AppFbAuthProvider implements AppAuthProvider {
  final FacebookAuth _fbAuth = FacebookAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<bool> get isSignedIn async {
    return await _fbAuth.accessToken != null ? true : false;
  }

  @override
  Future<void> signIn() async {
    try {
      LoginResult result = await _fbAuth.login(
        loginBehavior: LoginBehavior.dialogOnly,
        permissions: ['email'],
      );
      if (result.status == LoginStatus.success) {
        final String accessToken = result.accessToken!.token;

        final OAuthCredential fbCredentials =
            FacebookAuthProvider.credential(accessToken);

        await _auth.signInWithCredential(fbCredentials);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _fbAuth.logOut();
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
