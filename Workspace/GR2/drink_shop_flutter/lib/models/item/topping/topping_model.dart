// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ToppingModel {
  final String toppingId;
  final String toppingName;
  final int price;
  ToppingModel({
    required this.toppingId,
    required this.toppingName,
    required this.price,
  });

  ToppingModel copyWith({
    String? toppingId,
    String? toppingName,
    int? price,
  }) {
    return ToppingModel(
      toppingId: toppingId ?? this.toppingId,
      toppingName: toppingName ?? this.toppingName,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'toppingId': toppingId,
      'toppingName': toppingName,
      'price': price,
    };
  }

  factory ToppingModel.fromMap(Map<String, dynamic> map) {
    return ToppingModel(
      toppingId: map['toppingId'] as String,
      toppingName: map['toppingName'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToppingModel.fromJson(String source) => ToppingModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ToppingModel(toppingId: $toppingId, toppingName: $toppingName, price: $price)';

  @override
  bool operator ==(covariant ToppingModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.toppingId == toppingId &&
      other.toppingName == toppingName &&
      other.price == price;
  }

  @override
  int get hashCode => toppingId.hashCode ^ toppingName.hashCode ^ price.hashCode;
}
