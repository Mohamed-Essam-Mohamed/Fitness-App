import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularPercentIndicatorWidget extends StatelessWidget {
  const CircularPercentIndicatorWidget({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 30,
      lineWidth: 8.0,
      percent: index / 6,
      center: Text(
        '$index/6',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: AppColors.white,
            ),
      ),
      progressColor: AppColors.orange,
      backgroundColor: Colors.transparent,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
