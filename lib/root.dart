import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkOnboarding(context);
    });

    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }

  void _checkOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

    if (onboardingComplete) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
    }
  }
}
