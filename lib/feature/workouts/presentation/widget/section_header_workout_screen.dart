import 'package:fitness_app/core/constants/app_colors.dart';
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
  int selectCategoryIndex = 0;
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
          return TabContainerWidget(
            upcomingCategory: state.upcomingCategory,
            callBack: (id) => context
                .read<HomeCubit>()
                .doIntend(AppValues.english, GetUpcomingData(id: id)),
          );
        },
      ),
    );
  }
}
