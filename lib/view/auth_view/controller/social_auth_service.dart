import 'dart:io';
import 'package:calebshirthum/view/auth_view/controller/social_login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final SocialLoginController _socialLoginController = SocialLoginController();

  // ----------------------------
  // Google Sign-In
  // ----------------------------
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the Google authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User cancelled the login
        print("Google Sign-In cancelled by user");
        return null;
      }

      // Obtain the auth details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print("Google Sign-In successful: ${userCredential.user?.displayName}");

      _socialLoginController.socialLogin(
        email: userCredential.user?.email ?? "",
        image: userCredential.user?.photoURL ?? "",
        firstName: userCredential.user?.displayName ?? "",
      );

      return userCredential;
    } catch (e) {
      print("Error during Google Sign-In: $e");
      return null;
    }
  }

  Future<void> signInWithApple() async {
    try {
      if (!Platform.isIOS) {
        print("Apple Sign-In only available on iOS.");
        return;
      }

      // Get Apple ID credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      print("Apple Sign-In successful");
      print("Firebase user email: ${userCredential.user?.email}");
      print("Firebase displayName: ${userCredential.user?.displayName}");


      // Optionally, continue with Firebase sign-in if you want
      /*
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    final UserCredential userCredential =
        await _auth.signInWithCredential(oauthCredential);

    print("Apple Sign-In successful: ${userCredential.user?.displayName}");

    _socialLoginController.socialLogin(
      email: userCredential.user?.email ?? "",
      image: userCredential.user?.photoURL ?? "",
      firstName: userCredential.user?.displayName ?? "",
    );

    return userCredential;
    */
    } catch (e) {
      print("Error during Apple Sign-In: $e");
    }
  }




  Future<void> signOut() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await GoogleSignIn().signOut(); // Google Sign-Out
      }
      await _auth.signOut();
      print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  // ----------------------------
  // Get Current User
  // ----------------------------
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
