import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/constants/app_values.dart';
import 'package:fitness_app/feature/Exercise/presentation/view/exercise.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:fitness_app/feature/home/presentation/common/loading/category_list_loading.dart';
import 'package:fitness_app/feature/home/presentation/common/loading/tab_container_loading.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/container_blur_widget.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/tab_container_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingWorkoutsSection extends StatelessWidget {
  const UpcomingWorkoutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          LocaleKeys.Home_UpcomingWorkouts.tr(),
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w600, height: 1.20),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          // buildWhen: (previous, current) => previous.upcomingCategory != current.upcomingCategory,
          builder: (context, state) {
            if (state.isUpcomingCategoryLoading || state.isUpcomingCategoryFailure) {
              return const TabContainerLoading();
            }
            return TabContainerWidget(
              upcomingCategory: state.upcomingCategory,
              selectedIndex: context.read<HomeCubit>().selectedIndex,
              onTabSelected: (index) {
                context.read<HomeCubit>().selectedIndex = index;
              },
              callBack: (id) => context
                  .read<HomeCubit>()
                  .doIntend(AppValues.english, GetUpcomingData(id: id)),
            );
          },
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isUpcomingDataLoading || state.isUpcomingDataFailure) {
              return const CategoryListLoading(width: 80, height: 80);
            }
            return SizedBox(
              height: 80,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ExerciseScreen(primeMoverId: state.upcomingData[index].id),
                    ),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomCacheNetworkImage(
                          imageUrl: state.upcomingData[index].image,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          child: ContainerBlurWidget(
                            child: Text(
                              state.upcomingData[index].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(height: 1.20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: state.upcomingData.length,
              ),
            );
          },
        )
      ],
    );
  }
}
