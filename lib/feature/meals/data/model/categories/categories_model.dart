import 'package:fitness_app/feature/meals/domain/entity/categories/categories_entity.dart';

class CategoriesModel {
  CategoriesModel({this.categories});

  CategoriesModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }
  }

  List<Categories>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  CategoriesFoodEntity toEntity() => CategoriesFoodEntity(
    categories: categories?.map((e) => e.toEntity()).toList() ?? [],
  );
}

class Categories {
  Categories({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  Categories.fromJson(dynamic json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['idCategory'] = idCategory;
    map['strCategory'] = strCategory;
    map['strCategoryThumb'] = strCategoryThumb;
    map['strCategoryDescription'] = strCategoryDescription;
    return map;
  }

  CategoriesEntity toEntity() => CategoriesEntity(
    idCategory: idCategory,
    strCategory: strCategory,
    strCategoryThumb: strCategoryThumb,
    strCategoryDescription: strCategoryDescription,
  );
}
