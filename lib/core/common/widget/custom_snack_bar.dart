import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSnack(
      {required BuildContext context,
      required String title,
      required bool stateType,
      Duration? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(stateType ? '✅' : '🔴')
            ],
          ),
        )));
  }
}
