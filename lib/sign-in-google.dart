import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInService {
//   static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//
//   static Future<void> initialize() async {
//     await _googleSignIn.initialize(
//       clientId: '504764881404-3re80qeve4j3qbqtfln8knr026poiuuu.apps.googleusercontent.com',
//       // For web/iOS
//       serverClientId: 'YOUR_SERVER_CLIENT_ID.apps.googleusercontent.com', // For server-side validation
//     );
//   }
//
//   static Future<GoogleSignInAccount?> signIn() async {
//     try {
//       // Optional: Specify scopes at sign-in time (not in constructor)
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn(
//           scopes: ['email', 'profile']);
//       return googleUser;
//     } catch (error) {
//       print('Google Sign-In Error: $error');
//       return null;
//     }
//   }
//
//   static Future<void> signOut() async {
//     await _googleSignIn.signOut();
//   }
// }

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
    // try {
    //   final account = await _googleSignIn.signIn();
    //   if (account != null) {
    //     // Signed in successfully
    //     final email = account.email;
    //     final name = account.displayName;
    //     final photoUrl = account.photoUrl;
    //     // Store these in your app state / settings
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Signed in as $name ($email)')),
    //     );
    //   }
    // } catch (error) {
    //   print('Google Sign-In error: $error');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleSignIn(context),
      child: const Text('Sign in with Google'),
    );
  }
}
