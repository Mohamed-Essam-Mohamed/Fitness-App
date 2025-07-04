import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_assets.dart';

class BackgroundApp extends StatefulWidget {
  const BackgroundApp({super.key, required this.child});
  final Widget child;

  @override
  State<BackgroundApp> createState() => _BackgroundAppState();
}

class _BackgroundAppState extends State<BackgroundApp> {
  final List<String> _images = [
    ImageAsset.firstBg,
    ImageAsset.secondBg,
    ImageAsset.thirdBg,
    ImageAsset.fourthBg,
  ];

  int _currentIndex = 0;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _startSwitcher();
  }

  void _startSwitcher() {
    Future.delayed(const Duration(seconds: 6), _switchImage);
  }

  void _switchImage() {
    setState(() => _visible = false);

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _images.length;
        _visible = true;
      });
      _startSwitcher();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 700),
          curve: Curves.fastOutSlowIn,
          child: Image.asset(
            _images[_currentIndex],
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            cacheHeight: MediaQuery.of(context).size.height.toInt(),
            cacheWidth: MediaQuery.of(context).size.width.toInt(),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 8),
            child: const SizedBox(),
          ),
        ),
        Positioned.fill(child: widget.child),
      ],
    );
  }
}
