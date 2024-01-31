// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:drink_shop_flutter/models/order/order_line_model.dart';
import 'package:flutter/foundation.dart';

import 'package:drink_shop_flutter/models/order/order_model.dart';

class HistoryModel {
  final OrderModel order;
  final List<OrderLineModel> orderLines;
  HistoryModel({
    required this.order,
    required this.orderLines,
  });

  HistoryModel copyWith({
    OrderModel? order,
    List<OrderLineModel>? orderLines,
  }) {
    return HistoryModel(
      order: order ?? this.order,
      orderLines: orderLines ?? this.orderLines,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order': order.toMap(),
      'orderLines': orderLines.map((x) => x.toMap()).toList(),
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      order: OrderModel.fromMap(map['order'] as Map<String,dynamic>),
      orderLines: List<OrderLineModel>.from((map['orderLines'] as List<int>).map<OrderLineModel>((x) => OrderLineModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryModel.fromJson(String source) => HistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HistoryModel(order: $order, orderLines: $orderLines)';

  @override
  bool operator ==(covariant HistoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.order == order &&
      listEquals(other.orderLines, orderLines);
  }

  @override
  int get hashCode => order.hashCode ^ orderLines.hashCode;
}
