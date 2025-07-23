import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extensions/media_query_extensions.dart';
import 'package:fitness_app/feature/Exercise/presentation/widgets/custom_youtube_player.dart';

class TopExercisePreview extends StatelessWidget {
  const TopExercisePreview({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.videoUrl,
  });
  final String imageUrl;
  final String name;
  final String? videoUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: context.hp(40),
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: context.hp(20),
                color: Colors.grey,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported, color: Colors.white),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: AppColors.darkBackground.withValues(alpha: 0.7),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (videoUrl != null)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: Colors.black.withValues(alpha: 0.95),
                    builder: (_) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).pop(),
                      child: Scaffold(
                        backgroundColor: Colors.black,
                        body: SafeArea(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {},
                              child: CustomYoutubePlayer(videoUrl: videoUrl!),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.play_arrow, size: 50, color: AppColors.orange),
              ),
          ],
        ),
      ),
    );
  }
}
