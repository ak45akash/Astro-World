import 'package:flutter/material.dart';

import 'chart_detail_scaffold.dart';
import 'widgets/chart_views.dart';

class DashaChartPage extends StatelessWidget {
  const DashaChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartDetailScaffold(
      title: 'Dasha Timeline',
      subtitle:
          'Mahadasha and Antardasha periods with planetary rulers and transition dates.',
      builder: (context, bundle) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: DashaTimelineChartView(
                  periods: bundle.dashaTimeline,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...bundle.dashaTimeline.map(
              (period) => Card(
                child: ListTile(
                  leading: const Icon(Icons.timeline),
                  title: Text(period.name),
                  subtitle: Text(
                    '${_format(period.startDate)} → ${_format(period.endDate)}\nRuler: ${period.ruler}',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _format(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
}
