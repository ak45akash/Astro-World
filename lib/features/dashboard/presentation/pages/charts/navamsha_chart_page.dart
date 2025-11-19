import 'package:flutter/material.dart';

import 'chart_detail_scaffold.dart';
import 'utils/chart_data_converter.dart';
import 'widgets/astrology_chart_widget.dart';

class NavamshaChartPage extends StatelessWidget {
  const NavamshaChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartDetailScaffold(
      title: 'Navamsha Chart',
      subtitle:
          'Divisional chart revealing deeper spiritual and marital insights. Navamsha remains constant.',
      builder: (context, bundle) {
        final chartData = ChartDataConverter.convertToNavamshaChart(bundle);
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
                        'Navamsha Details',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow('Navamsha Lagna', bundle.navamsha),
                      _buildDetailRow('Navamsha Sign', chartData.lagnaSign),
                      const SizedBox(height: 12),
                      Text(
                        'Planets in Navamsha',
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
                        'The Navamsha chart (D-9) reveals deeper spiritual inclinations, marriage prospects, and inner strengths. It provides insights into the finer aspects of life that complement the main birth chart.',
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
            width: 140,
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
