import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/common/widget/custom_cache_network_image.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:fitness_app/feature/home/presentation/common/loading/category_list_loading.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/container_blur_widget.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationForYouSection extends StatelessWidget {
  const RecommendationForYouSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 7,
      children: [
        Text(
          LocaleKeys.Home_RecommendationForYou.tr(),
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w600, height: 1.20),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.isRecommendationForYouLoading ||
                state.isRecommendationForYouFailure) {
              return const CategoryListLoading(width: 104, height: 104);
            }
            return SizedBox(
              height: 104,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => context.pushNamed(Routes.foodScreen),
                  child: Container(
                    width: 104,
                    height: 104,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      alignment: Alignment.bottomCenter,
                      children: [
                        CustomCacheNetworkImage(
                          imageUrl: state.recommendationForYou[index].strCategoryThumb,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                          bottom: 0,
                          child: ContainerBlurWidget(
                            child: Text(
                              state.recommendationForYou[index].strCategory,
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
                itemCount: state.recommendationForYou.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
