import 'package:flutter/material.dart';
import '../theme/professional_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import '../../features/auth/data/auth_repository.dart';

/// Debug widget to switch between user roles for testing
/// This should only be visible in development mode
class RoleSwitcher extends ConsumerWidget {
  const RoleSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    
    return authState.when(
      data: (user) {
        if (user == null) return const SizedBox.shrink();
        
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.yellow, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.bug_report, color: Colors.yellow),
                  const SizedBox(width: 8),
                  const Text(
                    'Role Switcher (Debug Mode)',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Current: ${user.role}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildRoleButton(
                    context,
                    ref,
                    'Super Admin',
                    AppConstants.roleSuperAdmin,
                    user.role == AppConstants.roleSuperAdmin,
                  ),
                  _buildRoleButton(
                    context,
                    ref,
                    'Admin',
                    AppConstants.roleAdmin,
                    user.role == AppConstants.roleAdmin,
                  ),
                  _buildRoleButton(
                    context,
                    ref,
                    'Astrologer',
                    AppConstants.roleAstrologer,
                    user.role == AppConstants.roleAstrologer,
                  ),
                  _buildRoleButton(
                    context,
                    ref,
                    'Content Creator',
                    AppConstants.roleContentCreator,
                    user.role == AppConstants.roleContentCreator,
                  ),
                  _buildRoleButton(
                    context,
                    ref,
                    'End User',
                    AppConstants.roleEndUser,
                    user.role == AppConstants.roleEndUser,
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildRoleButton(
    BuildContext context,
    WidgetRef ref,
    String label,
    String role,
    bool isActive,
  ) {
    return ElevatedButton(
      onPressed: isActive
          ? null
          : () async {
              final authRepository = ref.read(authRepositoryProvider);
              final currentUser = ref.read(authStateProvider).value;
              
              if (currentUser != null) {
                await authRepository.updateUserProfile(
                  userId: currentUser.id,
                  updates: {'role': role},
                );
                
                if (context.mounted) {
                  // Navigate to appropriate dashboard
                  if (role == AppConstants.roleEndUser) {
                    context.go('/home');
                  } else {
                    context.go('/dashboard');
                  }
                }
              }
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? ProfessionalColors.success : ProfessionalColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: Text(label),
    );
  }
}

