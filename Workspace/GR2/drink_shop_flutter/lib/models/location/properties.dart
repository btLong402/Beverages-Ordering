// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Properties {
  final String? name;
  final String? state;
  final String? country;
  final String? countrycode;
  final String? city;
  final String? district;
  final String? locality;
  final String? osmKey;
  final String? osmValue;
  final String? osmType;
  final String? type;
  final int? osmId;
  final String? street;
  final String? housenumber;
  final String? postcode;
  final List<double>? extent;
  Properties({
    required this.name,
    required this.state,
    required this.country,
    required this.countrycode,
    this.city,
    this.district,
    this.locality,
    required this.osmKey,
    required this.osmValue,
    required this.osmType,
    this.type,
    required this.osmId,
    this.street,
    this.housenumber,
    this.postcode,
    this.extent,
  });

  Properties copyWith({
    String? name,
    String? state,
    String? country,
    String? countrycode,
    String? city,
    String? district,
    String? locality,
    String? osmKey,
    String? osmValue,
    String? osmType,
    String? type,
    int? osmId,
    String? street,
    String? housenumber,
    String? postcode,
    List<double>? extent,
  }) {
    return Properties(
      name: name ?? this.name,
      state: state ?? this.state,
      country: country ?? this.country,
      countrycode: countrycode ?? this.countrycode,
      city: city ?? this.city,
      district: district ?? this.district,
      locality: locality ?? this.locality,
      osmKey: osmKey ?? this.osmKey,
      osmValue: osmValue ?? this.osmValue,
      osmType: osmType ?? this.osmType,
      type: type ?? this.type,
      osmId: osmId ?? this.osmId,
      street: street ?? this.street,
      housenumber: housenumber ?? this.housenumber,
      postcode: postcode ?? this.postcode,
      extent: extent ?? this.extent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'state': state,
      'country': country,
      'countrycode': countrycode,
      'city': city,
      'district': district,
      'locality': locality,
      'osmKey': osmKey,
      'osmValue': osmValue,
      'osmType': osmType,
      'type': type,
      'osmId': osmId,
      'street': street,
      'housenumber': housenumber,
      'postcode': postcode,
      'extent': extent,
    };
  }

  factory Properties.fromMap(Map<String, dynamic> map) {
    return Properties(
      name: map['name'] != null ? map['name'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      countrycode:
          map['countrycode'] != null ? map['countrycode'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      locality: map['locality'] != null ? map['locality'] as String : null,
      osmKey: map['osmKey'] != null ? map['osmKey'] as String : null,
      osmValue: map['osmValue'] != null ? map['osmValue'] as String : null,
      osmType: map['osmType'] != null ? map['osmType'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      osmId: map['osmId'] != null ? map['osmId'] as int : null,
      street: map['street'] != null ? map['street'] as String : null,
      housenumber:
          map['housenumber'] != null ? map['housenumber'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      extent: map['extent'] != null
          ? List<double>.from(
              (map['extent'] as List<dynamic>).map((e) => e.toDouble()))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Properties.fromJson(String source) =>
      Properties.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Properties(name: $name, state: $state, country: $country, countrycode: $countrycode, city: $city, district: $district, locality: $locality, osmKey: $osmKey, osmValue: $osmValue, osmType: $osmType, type: $type, osmId: $osmId, street: $street, housenumber: $housenumber, postcode: $postcode, extent: $extent)';
  }

  @override
  bool operator ==(covariant Properties other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.state == state &&
        other.country == country &&
        other.countrycode == countrycode &&
        other.city == city &&
        other.district == district &&
        other.locality == locality &&
        other.osmKey == osmKey &&
        other.osmValue == osmValue &&
        other.osmType == osmType &&
        other.type == type &&
        other.osmId == osmId &&
        other.street == street &&
        other.housenumber == housenumber &&
        other.postcode == postcode &&
        listEquals(other.extent, extent);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        state.hashCode ^
        country.hashCode ^
        countrycode.hashCode ^
        city.hashCode ^
        district.hashCode ^
        locality.hashCode ^
        osmKey.hashCode ^
        osmValue.hashCode ^
        osmType.hashCode ^
        type.hashCode ^
        osmId.hashCode ^
        street.hashCode ^
        housenumber.hashCode ^
        postcode.hashCode ^
        extent.hashCode;
  }
}
