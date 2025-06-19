import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredContainerWidget extends StatelessWidget{
 final Widget child;
  const BlurredContainerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: 420,
                width: double.infinity ,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(20),
                ),
              ),
            ),
            // Foreground content
            Container(
              height: 420,
              width: double.infinity ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.black.withAlpha(20),
              ),
              child: child,

            ),
          ],
        ),
      ),
    );
  }
}