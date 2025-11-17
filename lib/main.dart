import 'package:flutter/material.dart';
import 'package:wander/add-trip.dart';
import 'package:wander/ai-summary.dart';
import 'package:wander/country-detail.dart';
import 'package:wander/home.dart';
import 'package:wander/map-setup.dart';
import 'package:wander/onboarding.dart';
import 'package:wander/paywall.dart';
import 'package:wander/profile.dart';
import 'package:wander/root.dart';
import 'package:wander/signin.dart';
import 'package:wander/theme.dart';
import 'package:wander/trip-details.dart';
import 'package:wander/welcome.dart';

void main() {
  runApp(const WanderApp());
}

class WanderApp extends StatelessWidget {
  const WanderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WanderBooks',
      theme: createTheme(Brightness.light),
      darkTheme: createTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      initialRoute: '/',
      routes: {
        '/': (context) => RootScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/signin': (context) => SignInScreen(),
        '/mapsetup': (context) => MapSetupScreen(),
        '/home': (context) => HomeScreen(),
        '/country': (context) => CountryDetailScreen(),
        '/addtrip': (context) => AddTripScreen(),
        '/tripdetail': (context) => TripDetailScreen(),
        '/aisummary': (context) => AiSummaryScreen(),
        '/profile': (context) => ProfileScreen(),
        '/paywall': (context) => PaywallScreen(),
        '/onboarding': (context) => OnboardingScreen(),
      },
    );
  }
}
