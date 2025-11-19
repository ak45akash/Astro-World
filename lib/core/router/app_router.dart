import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/phone_auth_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/astrologers/presentation/pages/astrologers_list_page.dart';
import '../../features/astrologers/presentation/pages/astrologer_detail_page.dart';
import '../../features/bookings/presentation/pages/bookings_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../core/providers/auth_provider.dart';
import '../../features/dashboard/presentation/pages/charts/varshfal_chart_page.dart';
import '../../features/dashboard/presentation/pages/charts/lagna_chart_page.dart';
import '../../features/dashboard/presentation/pages/charts/navamsha_chart_page.dart';
import '../../features/dashboard/presentation/pages/charts/moon_chart_page.dart';
import '../../features/dashboard/presentation/pages/charts/chalit_chart_page.dart';
import '../../features/dashboard/presentation/pages/charts/planetary_positions_page.dart';
import '../../features/dashboard/presentation/pages/charts/dasha_chart_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Handle auth state errors gracefully
      if (authState.hasError) {
        // If Firebase/auth fails, still allow navigation to login
        if (state.matchedLocation != '/login' &&
            state.matchedLocation != '/register' &&
            state.matchedLocation != '/phone-auth' &&
            state.matchedLocation != '/forgot-password') {
          return '/login';
        }
        return null;
      }

      if (authState.isLoading) {
        return null; // Wait for auth state to load
      }

      final isLoggedIn = authState.valueOrNull != null;
      final isLoggingIn = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register' ||
          state.matchedLocation == '/phone-auth' ||
          state.matchedLocation == '/forgot-password';

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return _getHomeRouteForRole(authState.value?.role ?? 'end_user');
      }
      return null;
    },
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
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
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
        path: '/astrologer/:id',
        builder: (context, state) {
          final astrologerId = state.pathParameters['id']!;
          return AstrologerDetailPage(astrologerId: astrologerId);
        },
      ),
      GoRoute(
        path: '/bookings',
        builder: (context, state) => const BookingsPage(),
      ),
      GoRoute(
        path: '/chat/:bookingId',
        builder: (context, state) {
          final bookingId = state.pathParameters['bookingId']!;
          return ChatPage(bookingId: bookingId);
        },
      ),
      GoRoute(
        path: '/chat/new/:id',
        builder: (context, state) {
          final astrologerId = state.pathParameters['id']!;
          // For new chats, use astrologer ID as booking ID
          return ChatPage(bookingId: 'new_$astrologerId');
        },
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/charts/varshfal',
        builder: (context, state) => const VarshfalChartPage(),
      ),
      GoRoute(
        path: '/charts/lagna',
        builder: (context, state) => const LagnaChartPage(),
      ),
      GoRoute(
        path: '/charts/navamsha',
        builder: (context, state) => const NavamshaChartPage(),
      ),
      GoRoute(
        path: '/charts/moon',
        builder: (context, state) => const MoonChartPage(),
      ),
      GoRoute(
        path: '/charts/chalit',
        builder: (context, state) => const ChalitChartPage(),
      ),
      GoRoute(
        path: '/charts/planets',
        builder: (context, state) => const PlanetaryPositionsPage(),
      ),
      GoRoute(
        path: '/charts/dasha',
        builder: (context, state) => const DashaChartPage(),
      ),
    ],
  );
});

String _getHomeRouteForRole(String role) {
  switch (role) {
    case 'super_admin':
    case 'admin':
    case 'astrologer':
    case 'content_creator':
      return '/dashboard';
    default:
      return '/home';
  }
}
