// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class SizeModel {
  final String sizeId;
  final String size;
  final int price;
  SizeModel({
    required this.sizeId,
    required this.size,
    required this.price,
  });

  SizeModel copyWith({
    String? sizeId,
    String? size,
    int? price,
  }) {
    return SizeModel(
      sizeId: sizeId ?? this.sizeId,
      size: size ?? this.size,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sizeId': sizeId,
      'size': size,
      'price': price,
    };
  }

  factory SizeModel.fromMap(Map<String, dynamic> map) {
    return SizeModel(
      sizeId: map['sizeId'] as String,
      size: map['size'] as String,
      price: map['price'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SizeModel.fromJson(String source) => SizeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SizeModel(sizeId: $sizeId, size: $size, price: $price)';

  @override
  bool operator ==(covariant SizeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.sizeId == sizeId &&
      other.size == size &&
      other.price == price;
  }

  @override
  int get hashCode => sizeId.hashCode ^ size.hashCode ^ price.hashCode;
}
