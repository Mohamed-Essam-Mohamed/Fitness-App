import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_colors.dart';

InkWell popWidget(BuildContext context, void Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 26, // Slightly wider to safely contain the content
      height: 26,
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('|',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white)),
              Text('<',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
