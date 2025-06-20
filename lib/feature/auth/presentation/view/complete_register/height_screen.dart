import 'dart:ui';
import 'package:fitness_app/feature/auth/presentation/view/complete_register/goal_screen.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fitness_app/core/constants/app_assets.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/extentions/media_query_extensions.dart';
import 'package:fitness_app/core/routes/routes.dart';
import 'package:fitness_app/feature/auth/presentation/view_model/models/collecting_data_model.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../widgets/pop_widget.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key, required this.data});
  final CollectingDataModel data;

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}
late RegisterCubit cubit;
class _HeightScreenState extends State<HeightScreen> {
  late int height;
  late ScrollController _scrollController;
  late double itemWidth;

  final int paddingItems = 3;
  final int numbersCount = 300;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    cubit = context.read<RegisterCubit>();
    height = cubit.height;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToHeight(height);
      _scrollController.addListener(_onScroll);
    });
  }


  void _onScroll() {
    final offset = _scrollController.offset +
        MediaQuery.of(context).size.width / 2 -
        itemWidth / 2;
    final index = (offset / itemWidth).round();

    final newHeight = (index - paddingItems + 1).clamp(1, numbersCount);
    if (newHeight != height) {
      setState(() => height = newHeight);
    }
  }

  void _scrollToHeight(int height) {
    final offset = ((height - 1 + paddingItems) * itemWidth) -
        MediaQuery.of(context).size.width / 2 +
        itemWidth / 2;
    _scrollController.jumpTo(offset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    itemWidth = MediaQuery.of(context).size.width * 0.16;
    final totalItems = numbersCount + paddingItems * 2;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageAsset.backgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: context.hp(1.5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: pop_widget(context),
                    ),
                    SizedBox(
                      width: context.wp(17),
                      height: context.hp(8),
                      child: Image.asset(ImageAsset.logo, fit: BoxFit.contain),
                    ),
                    SizedBox(width: context.wp(12)),
                  ],
                ),
                SizedBox(height: context.hp(9)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: Transform.rotate(
                        angle: -3,
                        child: CircularProgressIndicator(
                          value: 4 / 6,
                          strokeWidth: 4,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.orange),
                        ),
                      ),
                    ),
                    Text(
                      LocaleKeys.Authentication_stepProgressFour.tr(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.hp(3)),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.Authentication_whatIsYourHeight.tr(),
                        style: AppTheme.lightTheme.textTheme.labelLarge,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        LocaleKeys.Authentication_goalDescription.tr(),
                        style: AppTheme.lightTheme.textTheme.titleMedium!.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.hp(2)),
                SizedBox(
                  width: double.infinity,
                  height: context.hp(41),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
                            child: Container(
                              color: AppColors.darkBackground.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.Authentication_unitCm.tr(),
                            style: TextStyle(
                              color: AppColors.orange,
                              fontSize: 10,
                            ),
                          ),
                          SizedBox(
                            height: context.hp(13),
                            child: ListView.builder(
                              controller: _scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: totalItems,
                              itemBuilder: (context, index) {
                                final realIndex = index - paddingItems;

                                if (realIndex < 0 || realIndex >= numbersCount) {
                                  return SizedBox(width: itemWidth);
                                }

                                final number = realIndex + 1;
                                final viewportCenter = _scrollController.offset +
                                    MediaQuery.of(context).size.width / 2;
                                final itemCenter = index * itemWidth + itemWidth / 2;

                                final distanceFromCenter = (viewportCenter - itemCenter).abs();
                                final scale = (1.0 - (distanceFromCenter / (itemWidth * 4))).clamp(0.5, 1.0);
                                final fontSize = 36.0 * scale;

                                return Container(
                                  width: itemWidth,
                                  alignment: Alignment.center,
                                  child: Text(
                                    number.toString(),
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: number == height
                                          ? AppColors.orange
                                          : Colors.white.withOpacity(
                                        (1.1 - (distanceFromCenter / (itemWidth * 4))).clamp(0.2, 1.0),
                                      ),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const Icon(Icons.arrow_drop_up, size: 50, color: AppColors.orange),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: GestureDetector(
                              onTap: () {
                                final userData = widget.data.copyWith(height: height);
                                cubit.height=height;
                                Navigator.of(context).pushNamed(Routes.goal, arguments: userData);
                              },
                              child: Container(
                                height: context.hp(6),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.Authentication_next.tr(),
                                    style: AppTheme.lightTheme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
