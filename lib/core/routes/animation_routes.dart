import 'package:flutter/material.dart';

class AnimationRoute extends PageRouteBuilder<dynamic> {
  AnimationRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              Stack(children: [page]),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget widget,
          ) {
            const begin = 0.0;
            const end = 1.0;
            final tween = Tween(begin: begin, end: end);
            final curveAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.linearToEaseOut,
            );

            return ScaleTransition(
              scale: tween.animate(curveAnimation),
              child: widget,
            );
          },
        );
  Widget page;
}
