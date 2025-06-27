import 'package:flutter/material.dart';

class FadeInAssetImageWidget extends StatefulWidget {
  const FadeInAssetImageWidget(
      {super.key, required this.image, required this.index});
  final String image;
  final int index;

  @override
  State<FadeInAssetImageWidget> createState() => _FadeInAssetImageWidgetState();
}

class _FadeInAssetImageWidgetState extends State<FadeInAssetImageWidget> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300 * widget.index), () {
      if (mounted) {
        setState(() => _opacity = 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _opacity,
      child: Image.asset(
        widget.image,
        fit: BoxFit.cover,
        height: 56,
        width: 56,
      ),
    );
  }
}
