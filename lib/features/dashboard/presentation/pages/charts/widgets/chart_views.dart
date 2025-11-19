import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:astrology_app/core/theme/professional_theme.dart';
import 'package:astrology_app/features/dashboard/domain/models/chart_models.dart';

class VarshfalChartView extends StatelessWidget {
  final List<VarshfalPeriod> periods;

  const VarshfalChartView({super.key, required this.periods});

  @override
  Widget build(BuildContext context) {
    final spots = periods
        .asMap()
        .entries
        .map(
          (entry) => FlSpot(
            entry.key.toDouble(),
            entry.value.endDate
                .difference(entry.value.startDate)
                .inDays
                .toDouble(),
          ),
        )
        .toList();

    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: periods.length - 1.toDouble(),
          minY: 0,
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 36),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= periods.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      periods[index].title.split(' ').first,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: ProfessionalColors.accent,
              barWidth: 4,
              dotData: const FlDotData(show: true),
              spots: spots,
            ),
          ],
        ),
      ),
    );
  }
}

class PlanetaryBarChartView extends StatelessWidget {
  final List<PlanetPosition> positions;

  const PlanetaryBarChartView({super.key, required this.positions});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= positions.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      positions[index]
                          .planet
                          .substring(0, min(3, positions[index].planet.length)),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: positions
              .asMap()
              .entries
              .map(
                (entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.degree,
                      color: ProfessionalColors.accent,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(6)),
                      width: 18,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class DashaTimelineChartView extends StatelessWidget {
  final List<DashaPeriod> periods;

  const DashaTimelineChartView({super.key, required this.periods});

  @override
  Widget build(BuildContext context) {
    final base = periods.first.startDate;
    final maxDays = periods
        .map((p) => p.endDate.difference(base).inDays)
        .reduce(max)
        .toDouble();

    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceBetween,
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= periods.length) {
                    return const SizedBox.shrink();
                  }
                  return RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      periods[index].name,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: periods
              .asMap()
              .entries
              .map(
                (entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.endDate
                          .difference(entry.value.startDate)
                          .inDays
                          .toDouble(),
                      color: ProfessionalColors.primary,
                      width: 36,
                    ),
                  ],
                  showingTooltipIndicators: const [0],
                ),
              )
              .toList(),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final period = periods[group.x.toInt()];
                return BarTooltipItem(
                  '${period.name}\n${period.startDate.year} → ${period.endDate.year}',
                  Theme.of(context).textTheme.bodyMedium!,
                );
              },
            ),
          ),
          maxY: maxDays,
        ),
      ),
    );
  }
}

class HouseGridChartView extends StatelessWidget {
  final String title;
  final List<String> houses;

  const HouseGridChartView({
    super.key,
    required this.title,
    required this.houses,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: houses.length,
          itemBuilder: (context, index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: ProfessionalColors.divider),
                color: ProfessionalColors.surface,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    houses[index],
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class MoonOverlayChartView extends StatelessWidget {
  final String moonSign;
  final List<PlanetPosition> positions;

  const MoonOverlayChartView({
    super.key,
    required this.moonSign,
    required this.positions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Lunar Overview', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            painter: _MoonChartPainter(
              moonSign: moonSign,
              positions: positions,
            ),
            child: Center(
              child: Text(
                moonSign,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: ProfessionalColors.accent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MoonChartPainter extends CustomPainter {
  final String moonSign;
  final List<PlanetPosition> positions;

  _MoonChartPainter({
    required this.moonSign,
    required this.positions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 16;

    final circlePaint = Paint()
      ..color = ProfessionalColors.accent.withOpacity(0.1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, circlePaint);

    final orbitPaint = Paint()
      ..color = ProfessionalColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius * 0.75, orbitPaint);

    for (final position in positions.take(8)) {
      final angle = (position.degree / 360) * 2 * pi;
      final point = Offset(
        center.dx + radius * 0.75 * cos(angle),
        center.dy + radius * 0.75 * sin(angle),
      );

      canvas.drawCircle(
        point,
        6,
        Paint()..color = ProfessionalColors.primary,
      );

      final textPainter = TextPainter(
        text: TextSpan(
          text: position.planet.substring(0, min(2, position.planet.length)),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: ProfessionalColors.primary,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, point + const Offset(8, -8));
    }
  }

  @override
  bool shouldRepaint(covariant _MoonChartPainter oldDelegate) {
    return oldDelegate.moonSign != moonSign ||
        oldDelegate.positions != positions;
  }
}
