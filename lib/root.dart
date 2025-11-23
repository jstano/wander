import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

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
    context.go("/welcome");

    // final prefs = await SharedPreferences.getInstance();
    // bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    //
    // if (onboardingComplete) {
    //   Navigator.pushReplacementNamed(context, '/home');
    // } else {
    //   Navigator.pushReplacementNamed(context, '/onboarding');
    // }
  }
}
