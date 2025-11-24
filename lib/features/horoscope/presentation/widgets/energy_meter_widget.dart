import 'package:flutter/material.dart';
import '../../../../core/theme/professional_theme.dart';

class EnergyMeterWidget extends StatelessWidget {
  final int morning;
  final int afternoon;
  final int evening;

  const EnergyMeterWidget({
    super.key,
    required this.morning,
    required this.afternoon,
    required this.evening,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _buildEnergyBar('Morning', morning, Icons.wb_sunny),
          const SizedBox(height: 12),
          _buildEnergyBar('Afternoon', afternoon, Icons.wb_twilight),
          const SizedBox(height: 12),
          _buildEnergyBar('Evening', evening, Icons.nightlight_round),
        ],
      ),
    );
  }

  Widget _buildEnergyBar(String label, int value, IconData icon) {
    final percentage = value / 10.0;
    Color barColor;
    if (percentage >= 0.7) {
      barColor = ProfessionalColors.success;
    } else if (percentage >= 0.4) {
      barColor = ProfessionalColors.warning;
    } else {
      barColor = ProfessionalColors.error;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: ProfessionalColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: ProfessionalColors.textPrimary,
                  ),
                ),
              ],
            ),
            Text(
              '$value/10',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ProfessionalColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: ProfessionalColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(barColor),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}

