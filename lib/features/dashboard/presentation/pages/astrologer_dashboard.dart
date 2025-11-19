import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/professional_theme.dart';
import '../../domain/models/chart_models.dart';
import '../providers/chart_providers.dart';

class AstrologerDashboard extends ConsumerWidget {
  const AstrologerDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charts = ref.watch(chartBundleProvider);
    final theme = Theme.of(context);
    final user = ref.watch(authStateProvider).value;

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('Astrologer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(chartBundleProvider);
            },
            tooltip: 'Refresh charts',
          ),
        ],
      ),
      body: charts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _DashboardError(
          message: error.toString(),
          onRetry: () => ref.invalidate(chartBundleProvider),
        ),
        data: (bundle) => RefreshIndicator(
          onRefresh: () async {
            await ref.refresh(chartBundleProvider.future);
          },
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _DashboardHeader(
                name: user?.displayName ?? 'Guest',
                generatedAt: bundle.generatedAt,
                nextRefreshAt: bundle.nextRefreshAt,
              ),
              const SizedBox(height: 24),
              _SummaryGrid(bundle: bundle),
              const SizedBox(height: 24),
              _SectionCard(
                title: 'Varshfal Timeline',
                subtitle:
                    'Annual solar cycle insights from ${_formatDate(bundle.varshfal.first.startDate)} to ${_formatDate(bundle.varshfal.first.endDate)}',
                icon: Icons.autorenew,
                onTap: () => context.push('/charts/varshfal'),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Planetary Degrees & Nakshatras',
                subtitle:
                    '${bundle.planetaryPositions.length} planetary placements ready for review',
                icon: Icons.public,
                onTap: () => context.push('/charts/planets'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _SectionCard(
                      title: 'Moon Chart',
                      subtitle: bundle.moonSign,
                      icon: Icons.nightlight_round,
                      onTap: () => context.push('/charts/moon'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SectionCard(
                      title: 'Chalit Chart',
                      subtitle: 'Dynamic house adjustments',
                      icon: Icons.grid_view,
                      onTap: () => context.push('/charts/chalit'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _SectionCard(
                      title: 'Navamsha Chart',
                      subtitle: bundle.navamsha,
                      icon: Icons.layers,
                      onTap: () => context.push('/charts/navamsha'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SectionCard(
                      title: 'Dasha Timeline',
                      subtitle:
                          '${bundle.dashaTimeline.first.name} active • next transition ${_formatDate(bundle.dashaTimeline.first.endDate)}',
                      icon: Icons.timeline,
                      onTap: () => context.push('/charts/dasha'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Last generated • ${_formatDate(bundle.generatedAt)}',
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: ProfessionalColors.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} '
        '${_monthNames[date.month - 1]} ${date.year}';
  }

  static const List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}

class _DashboardHeader extends StatelessWidget {
  final String name;
  final DateTime generatedAt;
  final DateTime nextRefreshAt;

  const _DashboardHeader({
    required this.name,
    required this.generatedAt,
    required this.nextRefreshAt,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 28,
              backgroundColor: ProfessionalColors.primary,
              child: Icon(
                Icons.auto_awesome,
                color: ProfessionalColors.textLight,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back, $name',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your astrological insights have been refreshed. '
                    'Next refresh automatically occurs on '
                    '${AstrologerDashboard._formatDate(nextRefreshAt)}.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text(
                          'Generated ${AstrologerDashboard._formatDate(generatedAt)}',
                        ),
                      ),
                      Chip(
                        backgroundColor:
                            ProfessionalColors.accent.withOpacity(0.1),
                        label: const Text('Auto-refresh after next birthday'),
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
}

class _SummaryGrid extends StatelessWidget {
  final ChartBundle bundle;

  const _SummaryGrid({required this.bundle});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final itemWidth =
            isWide ? (constraints.maxWidth - 32) / 3 : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            SizedBox(
              width: itemWidth,
              child: _SummaryCard(
                title: 'Varshfal Cycle',
                value:
                    '${AstrologerDashboard._formatDate(bundle.varshfal.first.startDate)} → ${AstrologerDashboard._formatDate(bundle.varshfal.first.endDate)}',
                badge: 'Active',
                icon: Icons.autorenew,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _SummaryCard(
                title: 'Current Dasha',
                value: bundle.dashaTimeline.first.name,
                badge:
                    'Next: ${AstrologerDashboard._formatDate(bundle.dashaTimeline.first.endDate)}',
                icon: Icons.hourglass_top,
              ),
            ),
            SizedBox(
              width: itemWidth,
              child: _SummaryCard(
                title: 'Core Charts',
                value:
                    '${bundle.lagna} • ${bundle.navamsha} • ${bundle.moonSign}',
                badge: 'Stable',
                icon: Icons.brightness_auto,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String badge;
  final IconData icon;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.badge,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: ProfessionalColors.accent),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Chip(
              label: Text(badge),
              backgroundColor: ProfessionalColors.secondary.withOpacity(0.08),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _SectionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: ProfessionalColors.accent.withOpacity(0.12),
                child: Icon(icon, color: ProfessionalColors.accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _DashboardError({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: ProfessionalColors.error,
          ),
          const SizedBox(height: 12),
          Text(
            'Unable to load charts',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
