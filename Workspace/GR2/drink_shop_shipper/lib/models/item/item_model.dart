// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ItemModel {
  final String productId;
  final List<String> listTopping;
  final List<String> listSize;
  final String itemId;
  ItemModel({
    required this.productId,
    required this.listTopping,
    required this.listSize,
    required this.itemId,
  });
  

  ItemModel copyWith({
    String? productId,
    List<String>? listTopping,
    List<String>? listSize,
    String? itemId,
  }) {
    return ItemModel(
      productId: productId ?? this.productId,
      listTopping: listTopping ?? this.listTopping,
      listSize: listSize ?? this.listSize,
      itemId: itemId ?? this.itemId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'listTopping': listTopping,
      'listSize': listSize,
      'itemId': itemId,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      productId: map['productId'] as String,
      listTopping: List<String>.from((map['listTopping'] as List<dynamic>)),
      listSize: List<String>.from((map['listSize'] as List<dynamic>)),
      itemId: map['itemId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) => ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemModel(productId: $productId, listTopping: $listTopping, listSize: $listSize, itemId: $itemId)';
  }

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      listEquals(other.listTopping, listTopping) &&
      listEquals(other.listSize, listSize) &&
      other.itemId == itemId;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      listTopping.hashCode ^
      listSize.hashCode ^
      itemId.hashCode;
  }
}
