import 'package:flutter/material.dart';
import '../../../../core/theme/professional_theme.dart';

class StarRatingWidget extends StatelessWidget {
  final int rating;
  final double size;
  final Color? color;

  const StarRatingWidget({
    super.key,
    required this.rating,
    this.size = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: size,
          color: color ?? ProfessionalColors.warning,
        );
      }),
    );
  }
}

