import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppleSignInButton extends StatelessWidget {
  const AppleSignInButton({super.key});

  Future<void> _handleSignIn(BuildContext context) async {
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleSignIn(context),
      child: const Text('Sign in with Apple'),
    );
  }
}
