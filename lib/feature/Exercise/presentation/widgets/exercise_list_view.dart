import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercies_state.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercise_cubit.dart';

class ExerciseListView extends StatelessWidget {
  const ExerciseListView({
    super.key,
    required this.label,
    required this.cubit,
    required this.scrollController,
  });

  final String label;
  final ExerciseCubit cubit;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      bloc: cubit,
      builder: (context, state) {
        if (state.status == ExerciseStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == ExerciseStatus.failure) {
          return Center(child: Text('Error: ${state.error}', style: const TextStyle(color: Colors.white)));
        }

        final exercises = state.exercises;
        if (exercises.isEmpty) {
          return const Center(child: Text('No exercises found', style: TextStyle(color: Colors.white)));
        }

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
                    child: Container(color: AppColors.darkBackground.withValues(alpha: 0.7)),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: exercises.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  final videoUrl = exercise.videoUrl;
                  if (videoUrl == null || videoUrl.isEmpty) return const SizedBox();

                  return GestureDetector(
                    onTap: () {
                      cubit.setSelectedExercise(

                        videoUrl: videoUrl,
                        name: exercise.name,

                      );

                      if (scrollController.hasClients && scrollController.offset > 0) {
                        scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Align(
                                  alignment: Alignment.center,
                                  heightFactor: 0.7,
                                  child: Image.network(
                                    'https://img.youtube.com/vi/${_getYoutubeId(videoUrl)}/0.jpg',
                                    width: context.wp(27),
                                    height: context.hp(20),
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.grey[800],
                                      child: const Icon(Icons.error, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      exercise.name,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text("3 Groups * 15 Times", style: TextStyle(color: Colors.white70)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.play_circle_fill, color: AppColors.orange, size: 33),
                            ],
                          ),
                        ),
                        if (index != exercises.length - 1)
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(color: Colors.grey, thickness: 0.15),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _getYoutubeId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return '';
    if (uri.host.contains('youtu.be')) return uri.pathSegments.first;
    return uri.queryParameters['v'] ?? '';
  }
}
