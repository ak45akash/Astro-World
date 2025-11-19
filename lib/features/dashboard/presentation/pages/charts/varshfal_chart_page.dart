import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'chart_detail_scaffold.dart';
import 'widgets/chart_views.dart';

class VarshfalChartPage extends StatelessWidget {
  const VarshfalChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChartDetailScaffold(
      title: 'Varshfal Timeline',
      subtitle:
          'Annual solar return periods with focus areas and energy highlights.',
      builder: (context, bundle) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: VarshfalChartView(periods: bundle.varshfal),
              ),
            ),
            const SizedBox(height: 16),
            ...bundle.varshfal.map(
              (period) => Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: Text(period.title),
                  subtitle: Text(
                    '${_format(period.startDate)} → ${_format(period.endDate)}\n${period.focus}',
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
