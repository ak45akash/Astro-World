import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/phone_auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/astrologers/presentation/pages/astrologers_list_page.dart';
import '../../features/bookings/presentation/pages/bookings_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

final routerProviderSimple = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/phone-auth',
        builder: (context, state) => const PhoneAuthPage(),
      ),

      // Main Routes
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/astrologers',
        builder: (context, state) => const AstrologersListPage(),
      ),
      GoRoute(
        path: '/bookings',
        builder: (context, state) => const BookingsPage(),
      ),
      GoRoute(
        path: '/chat/:bookingId',
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId'] ?? 'test';
          return ChatPage(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
});

