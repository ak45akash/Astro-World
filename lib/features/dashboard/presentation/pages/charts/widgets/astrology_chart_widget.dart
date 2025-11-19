import 'package:flutter/material.dart';
import 'package:astrology_app/features/dashboard/domain/models/astrology_chart_models.dart';
import 'astrology_chart_painter.dart';

class AstrologyChartWidget extends StatelessWidget {
  final AstrologyChartData chartData;
  final double size;

  const AstrologyChartWidget({
    super.key,
    required this.chartData,
    this.size = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(20),
      child: CustomPaint(
        painter: AstrologyChartPainter(
          chartData: chartData,
          size: size,
        ),
        size: Size(size, size),
      ),
    );
  }
}
