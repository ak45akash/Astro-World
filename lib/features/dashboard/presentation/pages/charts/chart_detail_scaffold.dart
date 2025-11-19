import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/professional_theme.dart';
import '../../../domain/models/chart_models.dart';
import '../../providers/chart_providers.dart';

class ChartDetailScaffold extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Widget Function(BuildContext context, ChartBundle bundle) builder;

  const ChartDetailScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.builder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charts = ref.watch(chartBundleProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      backgroundColor: ProfessionalColors.background,
      body: charts.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Text(
            'Unable to load $title\n$error',
            textAlign: TextAlign.center,
          ),
        ),
        data: (bundle) => ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            builder(context, bundle),
          ],
        ),
      ),
    );
  }
}
