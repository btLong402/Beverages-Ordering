// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ItemOfCategory {
  final String categoryId;
  final List<String> listItem;
  ItemOfCategory({
    required this.categoryId,
    required this.listItem,
  });

  ItemOfCategory copyWith({
    String? categoryId,
    List<String>? listItem,
  }) {
    return ItemOfCategory(
      categoryId: categoryId ?? this.categoryId,
      listItem: listItem ?? this.listItem,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'listItem': listItem,
    };
  }

  factory ItemOfCategory.fromMap(Map<String, dynamic> map) {
    return ItemOfCategory(
      categoryId: map['categoryId'] as String,
      listItem: List<String>.from((map['listItem'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemOfCategory.fromJson(String source) =>
      ItemOfCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ItemOfCategory(categoryId: $categoryId, listItem: $listItem)';

  @override
  bool operator ==(covariant ItemOfCategory other) {
    if (identical(this, other)) return true;

    return other.categoryId == categoryId &&
        listEquals(other.listItem, listItem);
  }

  @override
  int get hashCode => categoryId.hashCode ^ listItem.hashCode;
}
