import 'package:flutter/material.dart';

import 'chart_detail_scaffold.dart';
import 'utils/chart_data_converter.dart';
import 'widgets/astrology_chart_widget.dart';
import '../../../../../core/theme/professional_theme.dart';

class PlanetaryPositionsPage extends StatelessWidget {
  const PlanetaryPositionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartDetailScaffold(
      title: 'Planetary Degrees & Nakshatras',
      subtitle:
          'Precise longitudinal placements with nakshatra and pada insights.',
      builder: (context, bundle) {
        final chartData = ChartDataConverter.convertToLagnaChart(bundle);
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
                        'Planetary Positions',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),
                      ...bundle.planetaryPositions.map(
                        (position) => Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  ProfessionalColors.accent.withOpacity(0.1),
                              child: Text(
                                position.planet.characters.first,
                                style: const TextStyle(
                                  color: ProfessionalColors.accent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            title: Text(
                              position.planet,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  'Degree: ${position.degree.toStringAsFixed(2)}°',
                                ),
                                Text('Nakshatra: ${position.nakshatra}'),
                                Text('Pada: ${position.pada}'),
                              ],
                            ),
                            trailing: Icon(
                              Icons.auto_awesome,
                              color: ProfessionalColors.accent,
                            ),
                          ),
                        ),
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
