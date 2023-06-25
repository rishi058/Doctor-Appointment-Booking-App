// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class StaffModel {
  String staffName;
  String staffUid;
  String staffProfPic;
  String staffAddress;
  String staffPhone;
  String staffRating;
  String email;
  String password;

  StaffModel({
    required this.staffName,
    required this.staffUid,
    required this.staffProfPic,
    required this.staffAddress,
    required this.staffPhone,
    this.staffRating = '3',
    required this.email,
    required this.password,
  });

  static StaffModel fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data()! as Map<String, dynamic>;
    return StaffModel(
        staffName: snapshot['staffName'],
        staffUid: snapshot['staffUid'],
        staffProfPic: snapshot['staffProfPic'],
        staffAddress: snapshot['staffAddress'],
        staffPhone: snapshot['staffPhone'],
        email: snapshot['email'],
        password: snapshot['password']);
  }

  StaffModel copyWith({
    String? staffName,
    String? staffUid,
    String? staffProfPic,
    String? staffAddress,
    String? staffPhone,
    String? staffRating,
    String? email,
    String? password,
  }) {
    return StaffModel(
      staffName: staffName ?? this.staffName,
      staffUid: staffUid ?? this.staffUid,
      staffProfPic: staffProfPic ?? this.staffProfPic,
      staffAddress: staffAddress ?? this.staffAddress,
      staffPhone: staffPhone ?? this.staffPhone,
      staffRating: staffRating ?? this.staffRating,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'staffName': staffName});
    result.addAll({'staffUid': staffUid});
    result.addAll({'staffProfPic': staffProfPic});
    result.addAll({'staffAddress': staffAddress});
    result.addAll({'staffPhone': staffPhone});
    result.addAll({'staffRating': staffRating});
    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      staffName: map['staffName'] ?? '',
      staffUid: map['staffUid'] ?? '',
      staffProfPic: map['staffProfPic'] ?? '',
      staffAddress: map['staffAddress'] ?? '',
      staffPhone: map['staffPhone'] ?? '',
      staffRating: map['staffRating'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StaffModel.fromJson(String source) =>
      StaffModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StaffModel(staffName: $staffName, staffUid: $staffUid, staffProfPic: $staffProfPic, staffAddress: $staffAddress, staffPhone: $staffPhone, staffRating: $staffRating, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StaffModel &&
        other.staffName == staffName &&
        other.staffUid == staffUid &&
        other.staffProfPic == staffProfPic &&
        other.staffAddress == staffAddress &&
        other.staffPhone == staffPhone &&
        other.staffRating == staffRating &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    return staffName.hashCode ^
        staffUid.hashCode ^
        staffProfPic.hashCode ^
        staffAddress.hashCode ^
        staffPhone.hashCode ^
        staffRating.hashCode ^
        email.hashCode ^
        password.hashCode;
  }
}
