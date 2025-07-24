import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class BottomSection extends StatefulWidget {
  const BottomSection({super.key});

  @override
  State<BottomSection> createState() => _BottomSectionState();
}

class _BottomSectionState extends State<BottomSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: const Divider(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('Or'),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: const Divider(),
            )
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: Image.asset(ImageAsset.facebook),
              onTap: () {},
            ),
            const SizedBox(width: 16),
            InkWell(
              child: Image.asset(ImageAsset.google),
              onTap: () {},
            ),
            const SizedBox(width: 16),
            InkWell(
              child: Image.asset(ImageAsset.apple),
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
