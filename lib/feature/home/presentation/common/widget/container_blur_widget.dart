import 'dart:ui';

import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ContainerBlurWidget extends StatelessWidget {
  const ContainerBlurWidget({super.key, required this.child, this.padding});
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        decoration: BoxDecoration(
          color: AppColors.black.withAlpha((0.01 * 255).toInt()),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black87, Colors.grey[900]!],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 13.0,
            sigmaY: 13.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
