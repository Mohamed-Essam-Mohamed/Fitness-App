import 'package:equatable/equatable.dart';

import '../../../../core/base_state/base_state.dart';

class MealState extends Equatable {
  const MealState({
    this.baseState,
  });
  final BaseState? baseState;

  MealState copyWith({
    BaseState? baseState,
  }) {
    return MealState(
      baseState: baseState ?? this.baseState,
    );
  }

  @override
  List<Object?> get props => [baseState];
}

sealed class MealsAction {}

final class DetailsAction extends MealsAction {
  final String mealId;

  DetailsAction({required this.mealId});
}
