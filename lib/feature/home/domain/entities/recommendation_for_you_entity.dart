class RecommendationForYouEntity {
  const RecommendationForYouEntity({this.categories = const []});

  final List<MealCategoryEntity> categories;
}

class MealCategoryEntity {
  const MealCategoryEntity({
    this.idCategory = '',
    this.strCategory = '',
    this.strCategoryThumb = '',
    this.strCategoryDescription = '',
  });

  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;
}
