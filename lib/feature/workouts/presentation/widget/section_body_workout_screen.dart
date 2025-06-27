import 'package:animate_do/animate_do.dart';
import 'package:fitness_app/core/common/animation/loading_shimmer.dart';
import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionBodyWorkoutScreen extends StatelessWidget {
  const SectionBodyWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.isUpcomingDataLoading || state.isUpcomingDataFailure) {
          return const DummyData();
        }
        return FadeInLeft(
          child: GridView.builder(
            itemCount: state.upcomingData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 18,
              crossAxisSpacing: 17,
            ),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    CustomCacheNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: state.upcomingData[index].image,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          textAlign: TextAlign.center,
                          state.upcomingData[index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class DummyData extends StatelessWidget {
  const DummyData({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 20,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 18,
            crossAxisSpacing: 17),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LoadingShimmer(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        });
  }
}
