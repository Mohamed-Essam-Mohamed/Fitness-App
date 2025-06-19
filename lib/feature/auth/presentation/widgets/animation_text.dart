import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class AnimationText extends StatelessWidget {
  const AnimationText(
      {super.key, required this.child, this.millDelay, this.millDuration});
  final Widget child;
  final int? millDelay;
  final int? millDuration;
  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      delay: Duration(milliseconds: millDelay ?? 1000),
      duration: Duration(milliseconds: millDuration ?? 1000),
      child: child,
    );
  }
}
