import 'package:flutter/material.dart';

import 'chart_detail_scaffold.dart';
import 'utils/chart_data_converter.dart';
import 'widgets/astrology_chart_widget.dart';

class ChalitChartPage extends StatelessWidget {
  const ChalitChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartDetailScaffold(
      title: 'Chalit Chart',
      subtitle:
          'Bhava Chalit adjustments showing house cusps and planet relocations. Refresh after significant progressions.',
      builder: (context, bundle) {
        final chartData = ChartDataConverter.convertToChalitChart(bundle);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: AstrologyChartWidget(
                  chartData: chartData,
                  size: 400,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bhava Chalit Details',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      ...bundle.chalitSummary.map(
                        (summary) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            summary,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Planets in Chalit Houses',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      ...chartData.planets.map(
                        (planet) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Text(
                                '${planet.planet}: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                'House ${planet.house} (${planet.sign})',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interpretation',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Bhava Chalit adjustments reposition planets into houses to reflect lived experience. '
                        'Use this view to validate transits and house strengths. The Chalit chart shows how planets actually manifest in your life experiences.',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
