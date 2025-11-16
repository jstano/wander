import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(child: Text('Welcome to WanderBooks', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/signin'),
              child: Text('Sign In'),
            ),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, '/signin'),
              child: Text('Create Account'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
