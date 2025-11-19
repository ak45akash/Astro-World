import 'package:flutter/material.dart';

import 'chart_detail_scaffold.dart';
import 'utils/chart_data_converter.dart';
import 'widgets/astrology_chart_widget.dart';

class MoonChartPage extends StatelessWidget {
  const MoonChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartDetailScaffold(
      title: 'Moon Chart',
      subtitle:
          'Emotional and mental landscape. Moon chart depends on Lagna and remains stable.',
      builder: (context, bundle) {
        final chartData = ChartDataConverter.convertToMoonChart(bundle);
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
                        'Moon Chart Details',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow('Moon Sign', bundle.moonSign),
                      _buildDetailRow('Moon Lagna', chartData.lagnaSign),
                      const SizedBox(height: 12),
                      Text(
                        'Planets in Moon Chart',
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
                        'The Moon chart reveals your emotional nature, mental patterns, and inner responses. It shows how you process feelings and react to life situations, providing insights into your psychological makeup.',
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
