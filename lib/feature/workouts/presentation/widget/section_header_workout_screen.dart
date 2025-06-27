import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/feature/home/presentation/common/loading/tab_container_loading.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SectionHeaderWorkoutScreen extends StatefulWidget {
  const SectionHeaderWorkoutScreen({super.key});

  @override
  State<SectionHeaderWorkoutScreen> createState() =>
      _SectionHeaderWorkoutScreenState();
}

class _SectionHeaderWorkoutScreenState
    extends State<SectionHeaderWorkoutScreen> {
  int selectCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (pre, cur) {
          if (pre.getUpcomingCategoryStatus != cur.getUpcomingCategoryStatus) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if (state.isUpcomingCategoryLoading ||
              state.isUpcomingCategoryFailure) {
            return const TabContainerLoading();
          }
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.upcomingCategory.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    selectCategoryIndex = index;
                    context.read<HomeCubit>().doIntend(
                        AppValues.english,
                        GetUpcomingData(
                            id: state
                                .upcomingCategory[selectCategoryIndex].id));
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: index == selectCategoryIndex
                              ? AppColors.orange
                              : Colors.transparent),
                      child: Center(
                        child: Text(
                          state.upcomingCategory[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
