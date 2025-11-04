import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_theme.dart';

class AnimatedGradient extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const AnimatedGradient({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 3),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
      ),
      child: child,
    ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: duration, color: Colors.white.withOpacity(0.3));
  }
}

