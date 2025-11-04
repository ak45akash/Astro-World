import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/gradient_card.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Header
                      const CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: AppColors.primaryStart,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'John Doe',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'john.doe@example.com',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Profile Cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            _buildProfileCard(
                              context,
                              icon: Icons.person_outline,
                              title: 'Personal Information',
                              subtitle: 'Manage your personal details',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            _buildProfileCard(
                              context,
                              icon: Icons.cake_outlined,
                              title: 'Birth Details',
                              subtitle: 'Add or update your birth information',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            _buildProfileCard(
                              context,
                              icon: Icons.wallet_outlined,
                              title: 'Wallet',
                              subtitle: 'Balance: ₹1,000',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            _buildProfileCard(
                              context,
                              icon: Icons.history,
                              title: 'Consultation History',
                              subtitle: 'View your past consultations',
                              onTap: () => context.push('/bookings'),
                            ),
                            const SizedBox(height: 16),
                            _buildProfileCard(
                              context,
                              icon: Icons.people_outline,
                              title: 'Referrals',
                              subtitle: 'Earn rewards by referring friends',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            _buildProfileCard(
                              context,
                              icon: Icons.settings_outlined,
                              title: 'Settings',
                              subtitle: 'App preferences and notifications',
                              onTap: () {},
                            ),
                            const SizedBox(height: 16),
                            _buildProfileCard(
                              context,
                              icon: Icons.logout,
                              title: 'Logout',
                              subtitle: 'Sign out of your account',
                              onTap: () {},
                              isDestructive: true,
                            ),
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
      ),
    );
  }

  Widget _buildProfileCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GradientCard(
      gradient: LinearGradient(
        colors: isDestructive
            ? [Colors.red.withOpacity(0.8), Colors.red.withOpacity(0.6)]
            : [Colors.white.withOpacity(0.2), Colors.white.withOpacity(0.1)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: isDestructive ? Colors.white : Colors.white,
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
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.white.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}
