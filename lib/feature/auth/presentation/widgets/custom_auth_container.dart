import 'dart:ui';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomAuthContainer extends StatelessWidget {
  const CustomAuthContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black87, Colors.grey[900]!],
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 15.0,
            sigmaY: 15.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
