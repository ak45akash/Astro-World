import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Teal Header
            _buildHeader(context, isMobile, isTablet),

            // Profile Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    // Profile Picture
                    CircleAvatar(
                      radius: isMobile ? 50 : 60,
                      backgroundColor: ProfessionalColors.primary.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: isMobile ? 50 : 60,
                        color: ProfessionalColors.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: isMobile ? 24 : 28,
                        fontWeight: FontWeight.bold,
                        color: ProfessionalColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@example.com',
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: ProfessionalColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Profile Options
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
                      ),
                      child: Column(
                        children: [
                          _buildProfileCard(
                            context,
                            icon: Icons.person_outline,
                            title: 'Personal Information',
                            subtitle: 'Manage your personal details',
                            onTap: () {},
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileCard(
                            context,
                            icon: Icons.cake_outlined,
                            title: 'Birth Details',
                            subtitle: 'Add or update your birth information',
                            onTap: () {},
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileCard(
                            context,
                            icon: Icons.wallet_outlined,
                            title: 'Wallet',
                            subtitle: 'Balance: ₹1,000',
                            onTap: () {},
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileCard(
                            context,
                            icon: Icons.history,
                            title: 'Consultation History',
                            subtitle: 'View your past consultations',
                            onTap: () => context.push('/bookings'),
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileCard(
                            context,
                            icon: Icons.people_outline,
                            title: 'Referrals',
                            subtitle: 'Earn rewards by referring friends',
                            onTap: () {},
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileCard(
                            context,
                            icon: Icons.settings_outlined,
                            title: 'Settings',
                            subtitle: 'App preferences and notifications',
                            onTap: () {},
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildProfileCard(
                            context,
                            icon: Icons.logout,
                            title: 'Logout',
                            subtitle: 'Sign out of your account',
                            onTap: () {},
                            isMobile: isMobile,
                            isTablet: isTablet,
                            isDestructive: true,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: ProfessionalColors.primary,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/home');
              }
            },
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              Container(
                width: isMobile ? 40 : 48,
                height: isMobile ? 40 : 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Astrotalk',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            onPressed: () {
              // Edit profile
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required bool isMobile,
    required bool isTablet,
    bool isDestructive = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ProfessionalColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? Colors.red.withOpacity(0.1)
                      : ProfessionalColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: isDestructive
                      ? Colors.red
                      : ProfessionalColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: ProfessionalColors.textPrimary,
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: ProfessionalColors.textSecondary,
                        fontSize: isMobile ? 13 : 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: ProfessionalColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
