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

      final email = userCredential.user?.email ?? "";

      // --- FIRST NAME HANDLING ---
      String firstName = "";

      // 1. Apple fullName (only available on FIRST login)
      if (appleCredential.givenName != null &&
          appleCredential!.givenName!.isNotEmpty) {
        firstName = appleCredential.givenName!;
      }
      // 2. Firebase displayName
      else if (userCredential.user?.displayName != null &&
          userCredential.user!.displayName!.isNotEmpty) {
        firstName = userCredential.user!.displayName!;
      }
      // 3. Fallback: email username
      else if (email.contains('@')) {
        firstName = email.split('@')[0];
      }

      // --- IMAGE HANDLING (APPLE NEVER RETURNS PHOTO) ---
      final image = userCredential.user?.photoURL ?? "";

      final finalImage = (image.isEmpty)
          ? "https://ui-avatars.com/api/?name=$firstName"
          : image;

      print("Apple Sign-In successful");
      print("Email: $email");
      print("First Name Used: $firstName");
      print("Image Used: $finalImage");

      _socialLoginController.socialLogin(
        email: email,
        image: finalImage,
        firstName: firstName,
      );
    } catch (e) {
      print("Error during Apple Sign-In: $e");
    }
  }

  Future<void> signOut() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await GoogleSignIn().signOut();
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
