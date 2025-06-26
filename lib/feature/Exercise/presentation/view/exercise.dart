import 'dart:ui';
import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercies_state.dart';
import 'package:fitness_app/feature/Exercise/presentation/view_model/exercise_cubit.dart';
import 'package:fitness_app/feature/Exercise/presentation/widgets/build_sector.dart';
import 'package:fitness_app/feature/Exercise/presentation/widgets/custom_youtube_player.dart';
import 'package:fitness_app/feature/auth/presentation/widgets/pop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key, required this.primeMoverId, this.injectedCubit});
  final String primeMoverId;
  final ExerciseCubit? injectedCubit;
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late ExerciseCubit cubit;
  String selectedDifficulty = 'Beginner';

  final Map<String, String> difficultyMap = {
    'Beginner': AppValues.beginnerId,
    'Intermediate': AppValues.intermediateId,
    'Advanced': AppValues.advanced,
  };

  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  String? selectedExerciseImage;
  String? selectedExerciseName;
  String? _currentVideoUrl;

  @override
  void initState() {
    super.initState();
    cubit = widget.injectedCubit ?? serviceLocator.get<ExerciseCubit>();
    fetchByDifficulty();
  }



  void fetchByDifficulty() async {
    await cubit.fetchExercises(
      muscleId:  widget.primeMoverId.isEmpty?"67c8499726895f87ce0aa9be":widget.primeMoverId,
      difficultyId: difficultyMap[selectedDifficulty]!,
    );

    final state = cubit.state;
    if (state.exercises.isNotEmpty) {
      final first = state.exercises.first;
      final muscleName = first.muscle?.trim();
      if (muscleName != null) {
        setState(() {
          selectedExerciseImage = 'https://img.youtube.com/vi/${_getYoutubeId(first.videoUrl ?? '')}/0.jpg';
          selectedExerciseName = first.name;
          _currentVideoUrl = first.videoUrl;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageAsset.backgroundExercise),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          children: [
            if (selectedExerciseImage != null)
              GestureDetector(
                onTap: () {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: ClipRRect(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        selectedExerciseImage!,
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
                            color: AppColors.darkBackground.withValues(alpha:  0.7),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 20,
                        child: Text(
                          selectedExerciseName ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (_currentVideoUrl != null)
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black.withValues(alpha:  0.95),
                              builder: (_) => GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => Navigator.of(context).pop(),
                                child: Scaffold(
                                  backgroundColor: Colors.black,
                                  body: SafeArea(
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: CustomYoutubePlayer(videoUrl: _currentVideoUrl!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Icon(Icons.play_arrow, size: 50, color: AppColors.orange),
                        ),
                      Positioned(
                          left: 15,
                          top: 15,
                          child: pop_widget(context,()=>Navigator.of(context).pop())),

                    ],
                  ),
                ),
              ),
            BuildSelector(
              difficultyMap: difficultyMap,
              selectedDifficulty: selectedDifficulty,
              pageController: _pageController,
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: context.hp(70),
              child: PageView.builder(
                controller: _pageController,
                itemCount: difficultyMap.length,
                onPageChanged: (index) {
                  setState(() {
                    selectedDifficulty = difficultyMap.keys.elementAt(index);
                  });
                  fetchByDifficulty();
                },
                itemBuilder: (context, index) {
                  final label = difficultyMap.keys.elementAt(index);
                  return _buildExerciseList(label);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseList(String label) {
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
                    child: Container(color: AppColors.darkBackground.withValues(alpha:  0.7)),
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
                      setState(() {
                        selectedExerciseImage = 'https://img.youtube.com/vi/${_getYoutubeId(videoUrl)}/0.jpg';
                        selectedExerciseName = exercise.name;
                        _currentVideoUrl = videoUrl;
                      });

                      if (_scrollController.hasClients && _scrollController.offset > 0) {
                        _scrollController.animateTo(
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
                            const  Icon(Icons.play_circle_fill, color: AppColors.orange, size: 33),                              // IconButton(

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
