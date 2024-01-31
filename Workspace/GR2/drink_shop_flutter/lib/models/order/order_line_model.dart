// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class OrderLineModel {
  final String? orderLineId;
  final String? orderId;
  final String productId;
  List<String> listTopping;
  String sizeId;
  int quantity;
  int subTotal;
  OrderLineModel({ 
    this.orderLineId,
    this.orderId,
    required this.productId,
    required this.listTopping,
    required this.sizeId,
    required this.quantity,
    required this.subTotal,
  });

  OrderLineModel copyWith({
    String? orderLineId,
    String? orderId,
    String? productId,
    List<String>? listTopping,
    String? sizeId,
    int? quantity,
    int? subTotal,
  }) {
    return OrderLineModel(
      orderLineId: orderLineId ?? this.orderLineId,
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      listTopping: listTopping ?? this.listTopping,
      sizeId: sizeId ?? this.sizeId,
      quantity: quantity ?? this.quantity,
      subTotal: subTotal ?? this.subTotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderLineId': orderLineId,
      'orderId': orderId,
      'productId': productId,
      'listTopping': listTopping,
      'sizeId': sizeId,
      'quantity': quantity,
      'subTotal': subTotal,
    };
  }

  factory OrderLineModel.fromMap(Map<String, dynamic> map) {
    return OrderLineModel(
      orderLineId: map['orderLineId'] as String,
      orderId: map['orderId'] as String,
      productId: map['productId'] as String,
      listTopping: (map['listTopping'] as List<dynamic>)
          .map((dynamic item) => item.toString())
          .toList(),
      sizeId: map['sizeId'] as String,
      quantity: map['quantity'] as int,
      subTotal: map['subTotal'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderLineModel.fromJson(String source) =>
      OrderLineModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderLineModel(orderLineId: $orderLineId, orderId: $orderId, productId: $productId, listTopping: $listTopping, sizeId: $sizeId, quantity: $quantity, subTotal: $subTotal)';
  }

  @override
  bool operator ==(covariant OrderLineModel other) {
    if (identical(this, other)) return true;

    return other.orderLineId == orderLineId &&
        other.orderId == orderId &&
        other.productId == productId &&
        listEquals(other.listTopping, listTopping) &&
        other.sizeId == sizeId &&
        other.quantity == quantity &&
        other.subTotal == subTotal;
  }

  @override
  int get hashCode {
    return orderLineId.hashCode ^
        orderId.hashCode ^
        productId.hashCode ^
        listTopping.hashCode ^
        sizeId.hashCode ^
        quantity.hashCode ^
        subTotal.hashCode;
  }
}
