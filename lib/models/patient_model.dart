import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String patientName;
  final String patientUid;
  final String patientPhone;
  final String patientProfilePic;
  final String patientAddress;
  final String patientAge;

  PatientModel({
    required this.patientName,
    required this.patientUid,
    required this.patientPhone,
    required this.patientProfilePic,
    required this.patientAddress,
    required this.patientAge ,
  });

  PatientModel copyWith({
    String? patientName,
    String? patientUid,
    String? patientPhone,
    String? patientProfilePic,
    String? patientAddress,
    String? patientAge,
  }) {
    return PatientModel(
      patientName: patientName ?? this.patientName,
      patientUid: patientUid ?? this.patientUid,
      patientPhone: patientPhone ?? this.patientPhone,
      patientProfilePic: patientProfilePic ?? this.patientProfilePic,
      patientAddress: patientAddress ?? this.patientAddress,
      patientAge: patientAge ?? this.patientAge,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'patientName': patientName});
    result.addAll({'patientUid': patientUid});
    result.addAll({'patientPhone': patientPhone});
    result.addAll({'patientProfilePic': patientProfilePic});
    result.addAll({'patientAddress': patientAddress});
    result.addAll({'patientAge': patientAge});

    return result;
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      patientName: map['patientName'] ?? '',
      patientUid: map['patientUid'] ?? '',
      patientPhone: map['patientPhone'] ?? '',
      patientProfilePic: map['patientProfilePic'] ?? '',
      patientAddress: map['patientAddress'] ?? '',
      patientAge: map['patientAge'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PatientModel(patientName: $patientName, patientUid: $patientUid, patientPhone: $patientPhone, patientProfilePic: $patientProfilePic, patientAddress: $patientAddress, patientAge: $patientAge)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PatientModel &&
        other.patientName == patientName &&
        other.patientUid == patientUid &&
        other.patientPhone == patientPhone &&
        other.patientProfilePic == patientProfilePic &&
        other.patientAddress == patientAddress &&
        other.patientAge == patientAge;
  }

  @override
  int get hashCode {
    return patientName.hashCode ^
        patientUid.hashCode ^
        patientPhone.hashCode ^
        patientProfilePic.hashCode ^
        patientAddress.hashCode ^
        patientAge.hashCode;
  }

  static PatientModel fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data()! as Map<String, dynamic>;
    return PatientModel(
        patientName: snapshot['patientName'] ?? "",
        patientUid: snapshot['patientUid'] ?? "",
        patientPhone: snapshot['patientPhone'] ?? "",
        patientProfilePic: snapshot['patientProfilePic'] ?? "",
        patientAddress: snapshot['patientAddress'] ?? "",
        patientAge: snapshot['patientAge'] ?? "");
  }
}
