import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/professional_theme.dart';
import 'features/dashboard/presentation/pages/super_admin_dashboard.dart';
import 'features/dashboard/presentation/pages/admin_dashboard.dart';
import 'features/dashboard/presentation/pages/astrologer_dashboard.dart';
import 'features/dashboard/presentation/pages/content_creator_dashboard.dart';

void main() {
  runApp(
    const ProviderScope(
      child: TestApp(),
    ),
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const TestLoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const TestHomePage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const TestDashboardPage(),
      ),
    ],
  );
});

class TestApp extends ConsumerWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(professionalThemeProvider);

    return MaterialApp.router(
      title: 'Astrology App',
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      routerConfig: router,
    );
  }
}

class TestLoginPage extends StatelessWidget {
  const TestLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('Astro World'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 64,
                    color: ProfessionalColors.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome to Astro World',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Professional Astrology Platform',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => context.go('/home'),
                      child: const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/dashboard'),
                    child: const Text('Go to Dashboard'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TestHomePage extends StatelessWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.go('/login'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 80,
              color: ProfessionalColors.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome to Astro World',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('View Dashboards'),
            ),
          ],
        ),
      ),
    );
  }
}

class TestDashboardPage extends StatefulWidget {
  const TestDashboardPage({super.key});

  @override
  State<TestDashboardPage> createState() => _TestDashboardPageState();
}

class _TestDashboardPageState extends State<TestDashboardPage> {
  String _selectedRole = 'super_admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('Dashboards'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ProfessionalColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ProfessionalColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Role to View Dashboard',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildChip('Super Admin', 'super_admin'),
                    _buildChip('Admin', 'admin'),
                    _buildChip('Astrologer', 'astrologer'),
                    _buildChip('Content Creator', 'content_creator'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildDashboard(_selectedRole),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String role) {
    final isSelected = _selectedRole == role;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _selectedRole = role);
        }
      },
      selectedColor: ProfessionalColors.primary,
      checkmarkColor: ProfessionalColors.textLight,
      labelStyle: TextStyle(
        color: isSelected ? ProfessionalColors.textLight : ProfessionalColors.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected ? ProfessionalColors.primary : ProfessionalColors.border,
      ),
    );
  }

  Widget _buildDashboard(String role) {
    switch (role) {
      case 'super_admin':
        return const SuperAdminDashboard();
      case 'admin':
        return const AdminDashboard();
      case 'astrologer':
        return const AstrologerDashboard();
      case 'content_creator':
        return const ContentCreatorDashboard();
      default:
        return const Center(
          child: Text(
            'Select a role',
            style: TextStyle(color: Colors.white),
          ),
        );
    }
  }
}
