import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../ui/screens/splash/splash_screen.dart';
import '../../ui/screens/onboarding/onboarding_screen.dart';
import '../../ui/screens/auth/login_screen.dart';
import '../../ui/screens/auth/register_screen.dart';
import '../../ui/screens/auth/otp_screen.dart';
import '../../ui/screens/kyc/kyc_screen.dart';
import '../../ui/screens/home/home_screen.dart';
import '../../ui/screens/match/match_room_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: '/kyc',
        builder: (context, state) => const KycScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/match/:id',
        builder: (context, state) => MatchRoomScreen(matchId: state.pathParameters['id']!),
      ),
    ],
  );
}
