// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShipperModel {
  final String? shipperName;
  final String? shipperId;
  final String? shipperEmail;
  final String? shipperPhone;
  final String? shipperRate;
  ShipperModel({
    this.shipperName,
    this.shipperId,
    this.shipperEmail,
    this.shipperPhone,
    this.shipperRate,
  });
  

  ShipperModel copyWith({
    String? shipperName,
    String? shipperId,
    String? shipperEmail,
    String? shipperPhone,
    String? shipperRate,
  }) {
    return ShipperModel(
      shipperName: shipperName ?? this.shipperName,
      shipperId: shipperId ?? this.shipperId,
      shipperEmail: shipperEmail ?? this.shipperEmail,
      shipperPhone: shipperPhone ?? this.shipperPhone,
      shipperRate: shipperRate ?? this.shipperRate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shipperName': shipperName,
      'shipperId': shipperId,
      'shipperEmail': shipperEmail,
      'shipperPhone': shipperPhone,
      'shipperRate': shipperRate,
    };
  }

  factory ShipperModel.fromMap(Map<String, dynamic> map) {
    return ShipperModel(
      shipperName: map['shipperName'] != null ? map['shipperName'] as String : null,
      shipperId: map['shipperId'] != null ? map['shipperId'] as String : null,
      shipperEmail: map['shipperEmail'] != null ? map['shipperEmail'] as String : null,
      shipperPhone: map['shipperPhone'] != null ? map['shipperPhone'] as String : null,
      shipperRate: map['shipperRate'] != null ? map['shipperRate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipperModel.fromJson(String source) => ShipperModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShipperModel(shipperName: $shipperName, shipperId: $shipperId, shipperEmail: $shipperEmail, shipperPhone: $shipperPhone, shipperRate: $shipperRate)';
  }

  @override
  bool operator ==(covariant ShipperModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.shipperName == shipperName &&
      other.shipperId == shipperId &&
      other.shipperEmail == shipperEmail &&
      other.shipperPhone == shipperPhone &&
      other.shipperRate == shipperRate;
  }

  @override
  int get hashCode {
    return shipperName.hashCode ^
      shipperId.hashCode ^
      shipperEmail.hashCode ^
      shipperPhone.hashCode ^
      shipperRate.hashCode;
  }
}
