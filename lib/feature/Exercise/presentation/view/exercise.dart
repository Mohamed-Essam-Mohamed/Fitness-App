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
import 'package:fitness_app/feature/Exercise/presentation/widgets/exercise_list_view.dart';
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

  @override
  void initState() {
    super.initState();
    cubit = widget.injectedCubit ?? serviceLocator.get<ExerciseCubit>();
    fetchByDifficulty();
  }

  Future<void> fetchByDifficulty() async {
    final difficultyId = difficultyMap[selectedDifficulty]!;

    await cubit.fetchExercises(
      muscleId:
          widget.primeMoverId.isEmpty ? "67c8499726895f87ce0aa9be" : widget.primeMoverId,
      difficultyId: difficultyId,
    );

    final first = cubit.state.exercises.isNotEmpty ? cubit.state.exercises.first : null;

    if (first != null && first.videoUrl != null) {
      cubit.setSelectedExercise(
        name: first.name,
        videoUrl: first.videoUrl!,
      );
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
        body: BlocBuilder<ExerciseCubit, ExerciseState>(
          bloc: cubit,
          builder: (context, state) {
            return ListView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              children: [
                if (state.selectedExerciseImage != null)
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
                            state.selectedExerciseImage!,
                            width: double.infinity,
                            height: context.hp(40),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: context.hp(20),
                              color: Colors.grey,
                              alignment: Alignment.center,
                              child: const Icon(Icons.image_not_supported,
                                  color: Colors.white),
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
                              state.selectedExerciseName ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (state.currentVideoUrl != null)
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
                                          child: CustomYoutubePlayer(
                                              videoUrl: state.currentVideoUrl!),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Icon(Icons.play_arrow,
                                  size: 50, color: AppColors.orange),
                            ),
                          Positioned(
                            left: 15,
                            top: 15,
                            child: popWidget(context, () => Navigator.of(context).pop()),
                          ),
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
                    onPageChanged: (index) async {
                      setState(() {
                        selectedDifficulty = difficultyMap.keys.elementAt(index);
                      });
                      await fetchByDifficulty();
                    },
                    itemBuilder: (context, index) {
                      final label = difficultyMap.keys.elementAt(index);
                      return ExerciseListView(
                        label: label,
                        cubit: cubit,
                        scrollController: _scrollController,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
