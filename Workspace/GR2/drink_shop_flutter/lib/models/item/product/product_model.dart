// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
class ProductModel {
  final String productId;
  final String productName;
  final String? description;
  final int price;
  final String? thumbnail;
  ProductModel({
    required this.productId,
    required this.productName,
    this.description,
    required this.price,
    this.thumbnail,
  });

  ProductModel copyWith({
    String? productId,
    String? productName,
    String? description,
    int? price,
    String? thumbnail,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'productName': productName,
      'description': description,
      'price': price,
      'thumbnail': thumbnail,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      price: map['price'] as int,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(productId: $productId, productName: $productName, description: $description, price: $price, thumbnail: $thumbnail)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.productId == productId &&
      other.productName == productName &&
      other.description == description &&
      other.price == price &&
      other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
      productName.hashCode ^
      description.hashCode ^
      price.hashCode ^
      thumbnail.hashCode;
  }
}
