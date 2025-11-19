import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander/features/ai_summary/ai_summary.dart';
import 'package:wander/features/country/country_detail.dart';
import 'package:wander/features/home/home.dart';
import 'package:wander/features/map_setup/map_setup.dart';
import 'package:wander/features/onboarding/onboarding.dart';
import 'package:wander/features/paywall/paywall.dart';
import 'package:wander/features/profile/profile.dart';
import 'package:wander/features/signin/signin.dart';
import 'package:wander/features/trip/add-trip.dart';
import 'package:wander/features/trip/trip-details.dart';
import 'package:wander/features/welcome/welcome.dart';
import 'package:wander/root.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const RootScreen(),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/signin',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/mapsetup',
        builder: (context, state) => const MapSetupScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/country',
        builder: (context, state) => const CountryDetailScreen(),
      ),
      GoRoute(
        path: '/addtrip',
        builder: (context, state) => const AddTripScreen(),
      ),
      GoRoute(
        path: '/tripdetail',
        builder: (context, state) => const TripDetailScreen(),
      ),
      GoRoute(
        path: '/aisummary',
        builder: (context, state) => const AiSummaryScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/paywall',
        builder: (context, state) => const PaywallScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
    ],
  );
});