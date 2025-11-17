import 'package:flutter/material.dart';
import 'package:wander/sign-in-apple.dart';
import 'package:wander/sign-in-google.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppleSignInButton(),
            SizedBox(height: 16),
            GoogleSignInButton(),
          ],
        ),
      ),
    );
  }
}
