import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  final Map<String, dynamic> _userData = {
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'phone': '+91 98765 43210',
    'birthDate': '1990-05-15',
    'birthTime': '10:30 AM',
    'birthPlace': 'Mumbai, Maharashtra',
    'zodiacSign': 'Taurus',
    'profileImage': null,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // Edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ProfessionalColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: _userData['profileImage'] != null
                            ? ClipOval(
                                child: Image.network(
                                  _userData['profileImage'],
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.person,
                                size: 60,
                                color: ProfessionalColors.primary,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: ProfessionalColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _userData['name'],
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userData['email'],
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Profile Sections
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Personal Information
                  _buildSection(
                    context,
                    'Personal Information',
                    [
                      _buildInfoTile(
                        context,
                        Icons.person_outline,
                        'Name',
                        _userData['name'],
                        () {},
                      ),
                      _buildInfoTile(
                        context,
                        Icons.email_outlined,
                        'Email',
                        _userData['email'],
                        () {},
                      ),
                      _buildInfoTile(
                        context,
                        Icons.phone_outlined,
                        'Phone',
                        _userData['phone'],
                        () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Birth Details
                  _buildSection(
                    context,
                    'Birth Details',
                    [
                      _buildInfoTile(
                        context,
                        Icons.calendar_today_outlined,
                        'Date of Birth',
                        _userData['birthDate'],
                        () {},
                      ),
                      _buildInfoTile(
                        context,
                        Icons.access_time_outlined,
                        'Time of Birth',
                        _userData['birthTime'],
                        () {},
                      ),
                      _buildInfoTile(
                        context,
                        Icons.location_on_outlined,
                        'Place of Birth',
                        _userData['birthPlace'],
                        () {},
                      ),
                      _buildInfoTile(
                        context,
                        Icons.star_outline,
                        'Zodiac Sign',
                        _userData['zodiacSign'],
                        null,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Account Settings
                  _buildSection(
                    context,
                    'Account',
                    [
                      _buildActionTile(
                        context,
                        Icons.wallet_outlined,
                        'Wallet',
                        'View balance & transactions',
                        () => context.go('/wallet'),
                      ),
                      _buildActionTile(
                        context,
                        Icons.history_outlined,
                        'Consultation History',
                        'View past consultations',
                        () => context.go('/bookings'),
                      ),
                      _buildActionTile(
                        context,
                        Icons.phone_outlined,
                        'Call History',
                        'Voice & video calls',
                        () => context.go('/call-history'),
                      ),
                      _buildActionTile(
                        context,
                        Icons.card_giftcard_outlined,
                        'Referral Program',
                        'Invite friends & earn rewards',
                        () {},
                      ),
                      _buildActionTile(
                        context,
                        Icons.settings_outlined,
                        'Settings',
                        'App preferences',
                        () {},
                      ),
                      _buildActionTile(
                        context,
                        Icons.logout,
                        'Logout',
                        'Sign out of your account',
                        () {},
                        isDestructive: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    IconData icon,
    String label,
    String value,
    VoidCallback? onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: ProfessionalColors.primary),
      title: Text(label, style: Theme.of(context).textTheme.bodySmall),
      subtitle: Text(
        value,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right, color: ProfessionalColors.textSecondary)
          : null,
      onTap: onTap,
    );
  }

  Widget _buildActionTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    final color = isDestructive ? ProfessionalColors.error : ProfessionalColors.primary;
    
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: isDestructive ? ProfessionalColors.error : null,
        ),
      ),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
      trailing: const Icon(Icons.chevron_right, color: ProfessionalColors.textSecondary),
      onTap: onTap,
    );
  }
}

