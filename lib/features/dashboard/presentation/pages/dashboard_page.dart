import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/providers/auth_provider.dart';
import 'super_admin_dashboard.dart';
import 'admin_dashboard.dart';
import 'astrologer_dashboard.dart';
import 'content_creator_dashboard.dart';
import '../../../../core/constants/app_constants.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show appropriate dashboard based on role
        switch (user.role) {
          case AppConstants.roleSuperAdmin:
            return const SuperAdminDashboard();
          case AppConstants.roleAdmin:
            return const AdminDashboard();
          case AppConstants.roleAstrologer:
            return const AstrologerDashboard();
          case AppConstants.roleContentCreator:
            return const ContentCreatorDashboard();
          default:
            // End user - redirect to home
            context.go('/home');
            return const Center(child: CircularProgressIndicator());
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Go to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
