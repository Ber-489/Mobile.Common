import 'package:firebase_auth/firebase_auth.dart';
import 'apple/apple_service.dart';
import 'facebook/facebook_service.dart';
import 'google/google_service.dart';

class SocialServices {
  static AppleService appleService = AppleService();
  static GoogleService googleService = GoogleService();
  static FacebookService facebookService = FacebookService();

  static void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
