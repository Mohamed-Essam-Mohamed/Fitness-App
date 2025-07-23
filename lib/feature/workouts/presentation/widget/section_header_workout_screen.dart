import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/feature/home/presentation/common/loading/tab_container_loading.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/tab_container_widget.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionHeaderWorkoutScreen extends StatefulWidget {
  const SectionHeaderWorkoutScreen({super.key});

  @override
  State<SectionHeaderWorkoutScreen> createState() => _SectionHeaderWorkoutScreenState();
}

class _SectionHeaderWorkoutScreenState extends State<SectionHeaderWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: BlocBuilder<HomeCubit, HomeState>(
        // buildWhen: (previous, current) => previous.upcomingCategory != current.upcomingCategory,
        builder: (context, state) {
          if (state.isUpcomingCategoryLoading || state.isUpcomingCategoryFailure) {
            return const TabContainerLoading();
          }
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: TabContainerWidget(
              upcomingCategory: state.upcomingCategory,
              selectedIndex: context.read<HomeCubit>().selectedIndex,
              onTabSelected: (index) {
                context.read<HomeCubit>().selectedIndex = index;
              },
              callBack: (id) => context
                  .read<HomeCubit>()
                  .doIntend(AppValues.english, GetUpcomingData(id: id)),
            ),
          );
        },
      ),
    );
  }
}
