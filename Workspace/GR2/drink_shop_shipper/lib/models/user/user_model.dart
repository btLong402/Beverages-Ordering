// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? userId;
  final String? userName;
  final String? userEmail;
  final String? userPhone;
  final String? userAddress;
  UserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPhone,
    this.userAddress,
  });

  UserModel copyWith({
    String? userId,
    String? userName,
    String? userEmail,
    String? userPhone,
    String? userAddress,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userPhone: userPhone ?? this.userPhone,
      userAddress: userAddress ?? this.userAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userAddress': userAddress,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] != null ? map['userId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      userEmail: map['userEmail'] != null ? map['userEmail'] as String : null,
      userPhone: map['userPhone'] != null ? map['userPhone'] as String : null,
      userAddress: map['userAddress'] != null ? map['userAddress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(userId: $userId, userName: $userName, userEmail: $userEmail, userPhone: $userPhone, userAddress: $userAddress)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userId == userId &&
      other.userName == userName &&
      other.userEmail == userEmail &&
      other.userPhone == userPhone &&
      other.userAddress == userAddress;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
      userName.hashCode ^
      userEmail.hashCode ^
      userPhone.hashCode ^
      userAddress.hashCode;
  }
}
