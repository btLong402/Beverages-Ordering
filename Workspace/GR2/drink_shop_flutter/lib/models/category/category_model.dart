// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class CategoryModel {
  final String categoryId;
  final String title;
  CategoryModel({
    required this.categoryId,
    required this.title,
  });

  CategoryModel copyWith({
    String? categoryId,
    String? title,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'title': title,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['categoryId'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(categoryId: $categoryId, title: $title)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.categoryId == categoryId &&
      other.title == title;
  }

  @override
  int get hashCode => categoryId.hashCode ^ title.hashCode;
}
