// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:drink_shop_flutter/models/location/geometry.dart';
import 'package:drink_shop_flutter/models/location/properties.dart';

class LocationRs {
  final Properties properties;
  final String type;
  final Geometry geometry;
  LocationRs({
    required this.properties,
    required this.type,
    required this.geometry,
  });

  LocationRs copyWith({
    Properties? properties,
    String? type,
    Geometry? geometry,
  }) {
    return LocationRs(
      properties: properties ?? this.properties,
      type: type ?? this.type,
      geometry: geometry ?? this.geometry,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'properties': properties.toMap(),
      'type': type,
      'geometry': geometry.toMap(),
    };
  }

  factory LocationRs.fromMap(Map<String, dynamic> map) {
    return LocationRs(
      properties: Properties.fromMap(map['properties'] as Map<String, dynamic>),
      type: map['type'] as String,
      geometry: Geometry.fromMap(map['geometry'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationRs.fromJson(String source) =>
      LocationRs.fromMap(json.decode(source) as Map<String, dynamic>);

  String getAddress() {
    List<String> parts = [];

    if (properties.name != null) parts.add(properties.name!);
    if (properties.locality != null) parts.add(properties.locality!);
    if (properties.district != null) parts.add(properties.district!);
    if (properties.city != null) parts.add(properties.city!);
    if (properties.country != null) parts.add(properties.country!);
    return parts.join(', ');
  }

  @override
  String toString() =>
      'Search(properties: $properties, type: $type, geometry: $geometry)';

  @override
  bool operator ==(covariant LocationRs other) {
    if (identical(this, other)) return true;

    return other.properties == properties &&
        other.type == type &&
        other.geometry == geometry;
  }

  @override
  int get hashCode => properties.hashCode ^ type.hashCode ^ geometry.hashCode;
}
