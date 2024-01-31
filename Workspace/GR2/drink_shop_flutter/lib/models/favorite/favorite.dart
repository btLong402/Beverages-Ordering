// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Favorite {
  final String customerId;
  final List<String> listProduct;
  Favorite({
    required this.customerId,
    required this.listProduct,
  });

  Favorite copyWith({
    String? customerId,
    List<String>? listProduct,
  }) {
    return Favorite(
      customerId: customerId ?? this.customerId,
      listProduct: listProduct ?? this.listProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'listProduct': listProduct,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      customerId: map['customerId'] as String,
      listProduct: List<String>.from((map['listProduct'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) =>
      Favorite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Favorite(customerId: $customerId, listProduct: $listProduct)';

  @override
  bool operator ==(covariant Favorite other) {
    if (identical(this, other)) return true;

    return other.customerId == customerId &&
        listEquals(other.listProduct, listProduct);
  }

  @override
  int get hashCode => customerId.hashCode ^ listProduct.hashCode;
}
