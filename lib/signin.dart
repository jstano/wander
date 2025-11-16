import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/mapsetup'), child: Text('Sign in with Apple')),
            SizedBox(height: 16),
            ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/mapsetup'), child: Text('Sign in with Google')),
          ],
        ),
      ),
    );
  }
}
