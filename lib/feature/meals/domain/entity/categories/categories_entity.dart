class CategoriesFoodEntity {
  CategoriesFoodEntity({
    required this.categories,
  });
  final List<CategoriesEntity> categories;
}
class CategoriesEntity {
  CategoriesEntity({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;
}