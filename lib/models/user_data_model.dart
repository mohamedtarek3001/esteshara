import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel {
  String? email;
  String? uid;
  String? userType;
  String? name;
  String? phone;
  String? aboutMe;
  String? major;
  int? count;
  bool? verified;
  double? rate;
  Timestamp? createdAt;

  UserDataModel({
    required this.email,
    required this.uid,
    required this.userType,
    required this.name,
    required this.phone,
    required this.aboutMe,
    required this.major,
    required this.createdAt,
    required this.count,
    required this.rate,
    required this.verified,

  });

  // Convert the UserDataModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uid': uid,
      'user_type': userType,
      'name': name,
      'phone': phone,
      'aboutMe': aboutMe,
      'major': major,
      'createdAt': createdAt,
      'rate': rate,
      'count': count,
      'verified': verified,
    };
  }

  // Create a UserDataModel from a Map
  factory UserDataModel.fromJson(Map<String, dynamic> map) {
    return UserDataModel(
      email: map['email'],
      uid: map['uid'],
      userType: map['user_type'],
      name: map['name'],
      phone: map['phone'],
      aboutMe: map['aboutMe'],
      major: map['major'],
      rate: map['rate'],
      count: map['count'],
      createdAt: map['createdAt'],
      verified: map['verified'],
    );
  }
}