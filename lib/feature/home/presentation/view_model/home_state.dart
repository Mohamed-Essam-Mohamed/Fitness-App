part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.categories = const [],
    this.getCategoriesStatus = Status.initial,
    this.recommendationToDay = const [],
    this.getRecommendationTDStatus = Status.initial,
    this.upcomingCategory = const [],
    this.getUpcomingCategoryStatus = Status.initial,
    this.upcomingData = const [],
    this.getUpcomingDataStatus = Status.initial,
    this.recommendationForYou = const [],
    this.getRecommendationFYStatus = Status.initial,
    this.dataUser = const UserDataEntity(),
    this.getDataInfoStatus = Status.initial,
  });
  final List<CategoryItemEntity> categories;
  final Status getCategoriesStatus;
  final List<CategoryItemEntity> recommendationToDay;
  final Status getRecommendationTDStatus;
  final List<MuscleItemGroupEntity> upcomingCategory;
  final Status getUpcomingCategoryStatus;
  final List<CategoryItemEntity> upcomingData;
  final Status getUpcomingDataStatus;
  final List<MealCategoryEntity> recommendationForYou;
  final Status getRecommendationFYStatus;
  final UserDataEntity dataUser;
  final Status getDataInfoStatus;

  // copyWith
  HomeState copyWith({
    List<CategoryItemEntity>? categories,
    Status? getCategoriesStatus,
    List<CategoryItemEntity>? recommendationToDay,
    Status? getRecommendationTDStatus,
    String? errorMessageMuscle,
    List<MuscleItemGroupEntity>? upcomingCategory,
    Status? getUpcomingCategoryStatus,
    List<CategoryItemEntity>? upcomingData,
    Status? getUpcomingDataStatus,
    List<MealCategoryEntity>? recommendationForYou,
    Status? getRecommendationFYStatus,
    UserDataEntity? dataUser,
    Status? getDataInfoStatus,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      getCategoriesStatus: getCategoriesStatus ?? this.getCategoriesStatus,
      recommendationToDay: recommendationToDay ?? this.recommendationToDay,
      getRecommendationTDStatus:
          getRecommendationTDStatus ?? this.getRecommendationTDStatus,
      upcomingCategory: upcomingCategory ?? this.upcomingCategory,
      getUpcomingCategoryStatus:
          getUpcomingCategoryStatus ?? this.getUpcomingCategoryStatus,
      upcomingData: upcomingData ?? this.upcomingData,
      getUpcomingDataStatus: getUpcomingDataStatus ?? this.getUpcomingDataStatus,
      recommendationForYou: recommendationForYou ?? this.recommendationForYou,
      getRecommendationFYStatus:
          getRecommendationFYStatus ?? this.getRecommendationFYStatus,
      dataUser: dataUser ?? this.dataUser,
      getDataInfoStatus: getDataInfoStatus ?? this.getDataInfoStatus,
    );
  }

  @override
  List<Object> get props => [
        categories,
        getCategoriesStatus,
        recommendationToDay,
        getRecommendationTDStatus,
        upcomingCategory,
        getUpcomingCategoryStatus,
        upcomingData,
        getUpcomingDataStatus,
        recommendationForYou,
        getRecommendationFYStatus,
        dataUser,
        getDataInfoStatus,
      ];
}

extension HomeStateExtension on HomeState {
  bool get isCategoriesLoading => getCategoriesStatus == Status.loading;
  bool get isRecommendationLoading => getRecommendationTDStatus == Status.loading;

  bool get isRecommendationForYouLoading => getRecommendationFYStatus == Status.loading;

  bool get isUpcomingCategoryLoading => getUpcomingCategoryStatus == Status.loading;
  bool get isUpcomingDataLoading => getUpcomingDataStatus == Status.loading;
  bool get isDataInfoLoading => getDataInfoStatus == Status.loading;

  bool get isCategoriesSuccess => getCategoriesStatus == Status.success;
  bool get isRecommendationSuccess => getRecommendationTDStatus == Status.success;
  bool get isDataInfoSuccess => getDataInfoStatus == Status.success;

  bool get isRecommendationForYouSuccess => getRecommendationFYStatus == Status.success;

  bool get isUpcomingCategorySuccess => getUpcomingCategoryStatus == Status.success;
  bool get isUpcomingDataSuccess => getUpcomingDataStatus == Status.success;

  bool get isCategoriesFailure => getCategoriesStatus == Status.failure;
  bool get isRecommendationFailure => getRecommendationTDStatus == Status.failure;

  bool get isRecommendationForYouFailure => getRecommendationFYStatus == Status.failure;

  bool get isUpcomingCategoryFailure => getUpcomingCategoryStatus == Status.failure;
  bool get isUpcomingDataFailure => getUpcomingDataStatus == Status.failure;
  bool get isDataInfoFailure => getDataInfoStatus == Status.failure;
}

sealed class HomeAction {}

class GetShotData extends HomeAction {}

class GetUpcomingData extends HomeAction {
  GetUpcomingData({required this.id});
  final String id;
}
