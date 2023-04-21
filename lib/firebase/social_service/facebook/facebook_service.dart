
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookService{
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Sign-In with Facebook - firebase
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await _facebookAuth.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return _firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  /// Sign-Out With Facebook - firebase
  Future<void> signOutWithFacebook() async {
    final AccessToken? accessToken = await _facebookAuth.accessToken;
    if (accessToken != null) {
      await _facebookAuth.logOut();
      await _firebaseAuth.signOut();
    }
  }
}