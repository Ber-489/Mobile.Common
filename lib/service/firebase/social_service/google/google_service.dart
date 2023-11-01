import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // scopes: [
    // 'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  // ],
    hostedDomain: ''
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if(googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Sign-Out With Google - firebase
  Future<void> signOutWithGoogle() async {
    final bool rs = await _googleSignIn.isSignedIn();
    if (rs) {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    }
  }
}
