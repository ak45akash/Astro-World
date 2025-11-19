import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../core/providers/auth_provider.dart'; // Commented for simple version
import 'super_admin_dashboard.dart';
import 'admin_dashboard.dart';
import 'astrologer_dashboard.dart';
import 'content_creator_dashboard.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/professional_theme.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  String _selectedRole = 'end_user';

  @override
  Widget build(BuildContext context) {
    // Simple role selector for UI testing
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: ProfessionalColors.background,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Role Selector
              Container(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Select Role to View Dashboard:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildRoleChip(
                                'Super Admin', AppConstants.roleSuperAdmin),
                            _buildRoleChip('Admin', AppConstants.roleAdmin),
                            _buildRoleChip(
                                'Astrologer', AppConstants.roleAstrologer),
                            _buildRoleChip('Content Creator',
                                AppConstants.roleContentCreator),
                            _buildRoleChip(
                                'End User', AppConstants.roleEndUser),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Dashboard Content
              Expanded(
                child: _buildDashboardForRole(_selectedRole),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleChip(String label, String role) {
    final isSelected = _selectedRole == role;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedRole = role;
          });
        }
      },
    );
  }

  Widget _buildDashboardForRole(String role) {
    switch (role) {
      case AppConstants.roleSuperAdmin:
        return const SuperAdminDashboard();
      case AppConstants.roleAdmin:
        return const AdminDashboard();
      case AppConstants.roleAstrologer:
        return const AstrologerDashboard();
      case AppConstants.roleContentCreator:
        return const ContentCreatorDashboard();
      default:
        return const Center(
          child: Text('End User - Go to Home Page'),
        );
    }
  }
}
