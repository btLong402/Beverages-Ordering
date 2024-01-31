// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';


class Geometry {
  final String type;
  final List<double> coordinates;
  Geometry({
    required this.type,
    required this.coordinates,
  });

  Geometry copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return Geometry(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory Geometry.fromMap(Map<String, dynamic> map) {
    return Geometry(
      type: map['type'] as String,
      coordinates: List<double>.from(
          (map['coordinates'] as List<dynamic>).map((e) => e.toDouble())),
    );
  }

  String toJson() => json.encode(toMap());

  factory Geometry.fromJson(String source) => Geometry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Geometry(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(covariant Geometry other) {
    if (identical(this, other)) return true;
  
    return 
      other.type == type &&
      listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}
