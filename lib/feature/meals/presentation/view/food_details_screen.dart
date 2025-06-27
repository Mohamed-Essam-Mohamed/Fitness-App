import 'package:fitness_app/core/base_state/base_state.dart';
import 'package:fitness_app/core/di/service_locator.dart';
import 'package:fitness_app/core/network/common/api_result.dart';
import 'package:fitness_app/feature/meals/domain/entity/food_details/response/meal_details_entity.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/meal/meal_cubit.dart';
import 'package:fitness_app/feature/meals/presentation/view_model/meal/meal_state.dart';
import 'package:fitness_app/feature/meals/presentation/widget/meal_details_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({super.key, required this.mealId});
  final String mealId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<MealCubit>()..doIntent(DetailsAction(mealId: mealId)),
      child: BlocBuilder<MealCubit, MealState>(
        builder: (context, state) {
          final baseState = state.baseState;

          if (baseState is BaseLoadingState) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (baseState is BaseErrorState) {
            return Scaffold(body: Center(child: Text(baseState.errorMessage)));
          }

          if (baseState is BaseSuccessState) {
            final mealDetails =
                (baseState.data as SuccessResult).data as MealDetailsEntity;

            return MealDetailsContent(
              mealDetailsEntity: mealDetails,
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
