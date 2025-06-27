import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/feature/home/presentation/common/widget/fade_in_asset_image_widget.dart';
import 'package:fitness_app/feature/home/presentation/view_model/home_cubit.dart';
import 'package:fitness_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 7,
      children: [
        Text(
          LocaleKeys.Home_Categories.tr(),
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w600, height: 1.20),
        ),
        Container(
          height: 90,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
          decoration: ShapeDecoration(
            color: AppColors.bgCategory,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: [
              const BoxShadow(
                color: AppColors.bgCategory,
                blurRadius: 5,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                previous.getCategoriesStatus != current.getCategoriesStatus,
            builder: (context, state) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
                    children: [
                      FadeInAssetImageWidget(
                        image: state.categories[index].image,
                        index: index,
                      ),
                      SizedBox(
                        width: 64,
                        child: Text(
                          state.categories[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.w400, height: 1.20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) =>
                    VerticalDivider(color: AppColors.gray[AppColors.colorCode80]),
                itemCount: state.categories.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
