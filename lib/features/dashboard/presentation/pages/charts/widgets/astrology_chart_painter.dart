import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../../../core/theme/professional_theme.dart';
import 'package:astrology_app/features/dashboard/domain/models/astrology_chart_models.dart';

class AstrologyChartPainter extends CustomPainter {
  final AstrologyChartData chartData;
  final double size;

  AstrologyChartPainter({
    required this.chartData,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 40;

    // Draw outer circle
    final outerPaint = Paint()
      ..color = ProfessionalColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, outerPaint);

    // Draw 12 houses
    final houseAngle = 2 * math.pi / 12;
    final housePaint = Paint()
      ..color = ProfessionalColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final signNames = [
      'Aries',
      'Taurus',
      'Gemini',
      'Cancer',
      'Leo',
      'Virgo',
      'Libra',
      'Scorpio',
      'Sagittarius',
      'Capricorn',
      'Aquarius',
      'Pisces'
    ];

    final signSymbols = [
      '♈',
      '♉',
      '♊',
      '♋',
      '♌',
      '♍',
      '♎',
      '♏',
      '♐',
      '♑',
      '♒',
      '♓'
    ];

    final planetSymbols = {
      'Sun': '☉',
      'Moon': '☽',
      'Mars': '♂',
      'Mercury': '☿',
      'Jupiter': '♃',
      'Venus': '♀',
      'Saturn': '♄',
      'Rahu': '☊',
      'Ketu': '☋',
    };

    // Draw house divisions and labels
    for (int i = 0; i < 12; i++) {
      final angle = i * houseAngle - math.pi / 2; // Start from top
      final startPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final endPoint = Offset(
        center.dx + (radius - 30) * math.cos(angle),
        center.dy + (radius - 30) * math.sin(angle),
      );

      canvas.drawLine(startPoint, endPoint, housePaint);

      // Draw house number
      final houseNumberPos = Offset(
        center.dx + (radius - 15) * math.cos(angle),
        center.dy + (radius - 15) * math.sin(angle),
      );

      final houseTextPainter = TextPainter(
        text: TextSpan(
          text: '${i + 1}',
          style: TextStyle(
            color: ProfessionalColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      houseTextPainter.layout();
      houseTextPainter.paint(
        canvas,
        Offset(
          houseNumberPos.dx - houseTextPainter.width / 2,
          houseNumberPos.dy - houseTextPainter.height / 2,
        ),
      );

      // Draw sign symbol in house
      final house = chartData.houses.firstWhere(
        (h) => h.houseNumber == i + 1,
        orElse: () => HousePosition(
          houseNumber: i + 1,
          sign: signNames[i],
          planets: [],
          startDegree: i * 30.0,
          endDegree: (i + 1) * 30.0,
        ),
      );

      final signIndex = signNames.indexOf(house.sign);
      if (signIndex >= 0) {
        final signPos = Offset(
          center.dx + (radius - 50) * math.cos(angle),
          center.dy + (radius - 50) * math.sin(angle),
        );

        final signTextPainter = TextPainter(
          text: TextSpan(
            text: signSymbols[signIndex],
            style: TextStyle(
              color: ProfessionalColors.accent,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        );
        signTextPainter.layout();
        signTextPainter.paint(
          canvas,
          Offset(
            signPos.dx - signTextPainter.width / 2,
            signPos.dy - signTextPainter.height / 2,
          ),
        );
      }
    }

    // Draw planets in houses
    for (final planet in chartData.planets) {
      final house = chartData.houses.firstWhere(
        (h) => h.houseNumber == planet.house,
        orElse: () => HousePosition(
          houseNumber: planet.house,
          sign: planet.sign,
          planets: [planet.planet],
          startDegree: (planet.house - 1) * 30.0,
          endDegree: planet.house * 30.0,
        ),
      );

      final houseAngle = 2 * math.pi / 12;
      final angle = (planet.house - 1) * houseAngle - math.pi / 2;
      final planetRadius = radius - 80;
      final planetPos = Offset(
        center.dx + planetRadius * math.cos(angle),
        center.dy + planetRadius * math.sin(angle),
      );

      // Draw planet circle
      final planetCirclePaint = Paint()
        ..color = ProfessionalColors.accent
        ..style = PaintingStyle.fill;
      canvas.drawCircle(planetPos, 12, planetCirclePaint);

      // Draw planet symbol
      final symbol = planetSymbols[planet.planet] ?? planet.planet[0];
      final planetTextPainter = TextPainter(
        text: TextSpan(
          text: symbol,
          style: TextStyle(
            color: ProfessionalColors.textLight,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      planetTextPainter.layout();
      planetTextPainter.paint(
        canvas,
        Offset(
          planetPos.dx - planetTextPainter.width / 2,
          planetPos.dy - planetTextPainter.height / 2,
        ),
      );

      // Draw planet label
      final labelPos = Offset(
        center.dx + (planetRadius - 20) * math.cos(angle),
        center.dy + (planetRadius - 20) * math.sin(angle),
      );

      final labelTextPainter = TextPainter(
        text: TextSpan(
          text: planet.planet,
          style: TextStyle(
            color: ProfessionalColors.textPrimary,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      labelTextPainter.layout();
      labelTextPainter.paint(
        canvas,
        Offset(
          labelPos.dx - labelTextPainter.width / 2,
          labelPos.dy - labelTextPainter.height / 2,
        ),
      );
    }

    // Draw center label (Lagna)
    final centerTextPainter = TextPainter(
      text: TextSpan(
        text: 'Lagna\n${chartData.lagnaSign}',
        style: TextStyle(
          color: ProfessionalColors.primary,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    centerTextPainter.layout(maxWidth: 100);
    centerTextPainter.paint(
      canvas,
      Offset(
        center.dx - centerTextPainter.width / 2,
        center.dy - centerTextPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant AstrologyChartPainter oldDelegate) {
    return oldDelegate.chartData != chartData || oldDelegate.size != size;
  }
}
