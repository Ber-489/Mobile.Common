
import 'apple/apple_service.dart';
import 'facebook/facebook_service.dart';
import 'google/google_service.dart';

class SocialServices {
  static AppleService appleService = AppleService();
  static GoogleService googleService = GoogleService();
  static FacebookService facebookService = FacebookService();

  static Future<void> signOut() async {
    await facebookService.signOutWithFacebook();
    await googleService.signOutWithGoogle();
    await appleService.signOutWithApple();
  }
}
