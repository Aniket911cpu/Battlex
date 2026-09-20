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
import '../../ui/screens/my_matches/my_matches_screen.dart';
import '../../ui/screens/leaderboard/leaderboard_screen.dart';
import '../../ui/screens/profile/profile_screen.dart';
import '../../ui/screens/profile/edit_profile_screen.dart';
import '../../ui/screens/wallet/wallet_screen.dart';
import '../../ui/screens/wallet/add_cash_screen.dart';
import '../../ui/screens/wallet/withdraw_screen.dart';
import '../../ui/screens/wallet/transaction_history_screen.dart';
import '../../ui/screens/membership/membership_screen.dart';
import '../../ui/screens/refer/refer_screen.dart';
import '../../ui/screens/notifications/notifications_screen.dart';
import '../../ui/screens/settings/settings_screen.dart';
import '../../ui/screens/labs/labs_screen.dart';

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
      GoRoute(
        path: '/my-matches',
        builder: (context, state) => const MyMatchesScreen(),
      ),
      GoRoute(
        path: '/leaderboard',
        builder: (context, state) => const LeaderboardScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/profile/edit',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/wallet',
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        path: '/wallet/add-cash',
        builder: (context, state) => const AddCashScreen(),
      ),
      GoRoute(
        path: '/wallet/withdraw',
        builder: (context, state) => const WithdrawScreen(),
      ),
      GoRoute(
        path: '/wallet/transactions',
        builder: (context, state) => const TransactionHistoryScreen(),
      ),
      GoRoute(
        path: '/membership',
        builder: (context, state) => const MembershipScreen(),
      ),
      GoRoute(
        path: '/refer',
        builder: (context, state) => const ReferScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/labs',
        builder: (context, state) => const LabsScreen(),
      ),
    ],
  );
}

