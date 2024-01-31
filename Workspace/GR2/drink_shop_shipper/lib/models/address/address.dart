// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String? address;
  final GeoPoint? point;
  Address({
    this.address,
    this.point,
  });

  Address copyWith({
    String? address,
    GeoPoint? point,
  }) {
    return Address(
      address: address ?? this.address,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'point': point?.toMap(),
    };
  }

  factory Address.fromMap(dynamic map) {
    if (map is Map<String, dynamic>) {
      return Address(
        address: map['address'] as String,
        point: GeoPointExtension.fromMap(map['point'] as Map<String, dynamic>),
      );
    } else if (map is String) {
      // If it's a string, attempt to convert it to a Map<String, dynamic>
      try {
        final decodedMap = json.decode(map) as Map<String, dynamic>;
        return Address.fromMap(decodedMap);
      } catch (e) {
        throw ArgumentError('Failed to convert string to Map: $map');
      }
    } else {
      throw ArgumentError('Invalid type for address: $map');
    }
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Address(address: $address, point: $point)';

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.point?.latitude == point?.latitude &&
        other.point?.longitude == point?.longitude;
  }

  @override
  int get hashCode => address.hashCode ^ point.hashCode;
}

extension GeoPointExtension on GeoPoint {
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static GeoPoint fromMap(Map<String, dynamic> map) {
    return GeoPoint(
      map['latitude'] as double,
      map['longitude'] as double,
    );
  }
}
