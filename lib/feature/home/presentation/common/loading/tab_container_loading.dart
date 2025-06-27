import 'package:fitness_app/core/common/animation/loading_shimmer.dart';
import 'package:fitness_app/feature/home/domain/entities/upcoming_workouts_category_entity.dart';
import 'package:flutter/material.dart';

class TabContainerLoading extends StatelessWidget {
  const TabContainerLoading({super.key});
  @override
  Widget build(BuildContext context) {
    final List upcomingCategory = List.filled(10, const UpcomingWorkoutsCategoryEntity());
    return DefaultTabController(
      length: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: Colors.transparent,
            indicator: const BoxDecoration(),
            dividerColor: Colors.transparent,
            labelColor: Colors.transparent,
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            tabAlignment: TabAlignment.start,
            onTap: (index) {},
            tabs: upcomingCategory
                .map((source) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: LoadingShimmer(
                        borderRadius: BorderRadius.circular(20),
                        width: 75,
                        height: 30,
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
