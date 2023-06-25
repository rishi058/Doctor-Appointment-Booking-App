import 'dart:convert';

class AppointmentModel {
  String appointmentId;
  String dateOfAppointment;
  String timeOfAppointment;
  String patientUid;
  String patientName;
  String patientPhone;
  String baseFee;
  String reason;
  String patientAddress;
  String assignedStaffName;
  String assignedStaffEmail;
  String assignedStaffUid;
  String assignedStaffPhone;
  String status;
  String paymentStatus;
  String secretOtp;
  String duration = "1";
  bool isFeedBackGiven;
  AppointmentModel({
    required this.appointmentId,
    required this.dateOfAppointment,
    required this.timeOfAppointment,
    required this.patientUid,
    required this.patientName,
    required this.patientPhone,
    this.baseFee = "",
    required this.reason,
    required this.patientAddress,
    this.assignedStaffName = "",
    this.assignedStaffEmail = "",
    this.assignedStaffUid = "",
    this.assignedStaffPhone = "",
    required this.status,
    required this.paymentStatus,
    required this.secretOtp,
    required this.duration,
    this.isFeedBackGiven = false,
  });

  AppointmentModel copyWith({
    String? appointmentId,
    String? dateOfAppointment,
    String? timeOfAppointment,
    String? patientUid,
    String? patientName,
    String? patientPhone,
    String? baseFee,
    String? reason,
    String? patientAddress,
    String? assignedStaffName,
    String? assignedStaffEmail,
    String? assignedStaffUid,
    String? assignedStaffPhone,
    String? status,
    String? paymentStatus,
    String? secretOtp,
    bool? isFeedBackGiven,
  }) {
    return AppointmentModel(
      appointmentId: appointmentId ?? this.appointmentId,
      dateOfAppointment: dateOfAppointment ?? this.dateOfAppointment,
      timeOfAppointment: timeOfAppointment ?? this.timeOfAppointment,
      patientUid: patientUid ?? this.patientUid,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      baseFee: baseFee ?? this.baseFee,
      reason: reason ?? this.reason,
      patientAddress: patientAddress ?? this.patientAddress,
      assignedStaffName: assignedStaffName ?? this.assignedStaffName,
      assignedStaffEmail: assignedStaffEmail ?? this.assignedStaffEmail,
      assignedStaffUid: assignedStaffUid ?? this.assignedStaffUid,
      assignedStaffPhone: assignedStaffPhone ?? this.assignedStaffPhone,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      secretOtp: secretOtp ?? this.secretOtp,
      duration: duration,
      isFeedBackGiven: isFeedBackGiven ?? this.isFeedBackGiven,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'appointmentId': appointmentId});
    result.addAll({'dateOfAppointment': dateOfAppointment});
    result.addAll({'timeOfAppointment': timeOfAppointment});
    result.addAll({'patientUid': patientUid});
    result.addAll({'patientName': patientName});
    result.addAll({'patientPhone': patientPhone});
    result.addAll({'baseFee': baseFee});
    result.addAll({'reason': reason});
    result.addAll({'patientAddress': patientAddress});
    result.addAll({'assignedStaffName': assignedStaffName});
    result.addAll({'assignedStaffEmail': assignedStaffEmail});
    result.addAll({'assignedStaffUid': assignedStaffUid});
    result.addAll({'assignedStaffPhone': assignedStaffPhone});
    result.addAll({'status': status});
    result.addAll({'paymentStatus': paymentStatus});
    result.addAll({'secretOtp': secretOtp});
    result.addAll({'duration': duration});
    result.addAll({'isFeedBackGiven': isFeedBackGiven});

    return result;
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      appointmentId: map['appointmentId'] ?? '',
      dateOfAppointment: map['dateOfAppointment'] ?? '',
      timeOfAppointment: map['timeOfAppointment'] ?? '',
      patientUid: map['patientUid'] ?? '',
      patientName: map['patientName'] ?? '',
      patientPhone: map['patientPhone'] ?? '',
      baseFee: map['baseFee'] ?? '',
      reason: map['reason'] ?? '',
      patientAddress: map['patientAddress'] ?? '',
      assignedStaffName: map['assignedStaffName'] ?? '',
      assignedStaffEmail: map['assignedStaffEmail'] ?? '',
      assignedStaffUid: map['assignedStaffUid'] ?? '',
      assignedStaffPhone: map['assignedStaffPhone'] ?? '',
      status: map['status'] ?? '',
      paymentStatus: map['paymentStatus'] ?? '',
      secretOtp: map['secretOtp'] ?? '',
      duration: map['duration'] ?? '',
      isFeedBackGiven: map['isFeedBackGiven'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppointmentModel(appointmentId: $appointmentId, dateOfAppointment: $dateOfAppointment, timeOfAppointment: $timeOfAppointment, patientUid: $patientUid, patientName: $patientName, patientPhone: $patientPhone, baseFee: $baseFee, reason: $reason, patientAddress: $patientAddress, assignedStaffName: $assignedStaffName, assignedStaffEmail: $assignedStaffEmail, assignedStaffUid: $assignedStaffUid, assignedStaffPhone: $assignedStaffPhone, status: $status, paymentStatus: $paymentStatus, secretOtp: $secretOtp, isFeedBackGiven: $isFeedBackGiven)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppointmentModel &&
        other.appointmentId == appointmentId &&
        other.dateOfAppointment == dateOfAppointment &&
        other.timeOfAppointment == timeOfAppointment &&
        other.patientUid == patientUid &&
        other.patientName == patientName &&
        other.patientPhone == patientPhone &&
        other.baseFee == baseFee &&
        other.reason == reason &&
        other.patientAddress == patientAddress &&
        other.assignedStaffName == assignedStaffName &&
        other.assignedStaffUid == assignedStaffUid &&
        other.assignedStaffPhone == assignedStaffPhone &&
        other.status == status &&
        other.paymentStatus == paymentStatus &&
        other.secretOtp == secretOtp &&
        other.isFeedBackGiven == isFeedBackGiven;
  }

  @override
  int get hashCode {
    return appointmentId.hashCode ^
        dateOfAppointment.hashCode ^
        timeOfAppointment.hashCode ^
        patientUid.hashCode ^
        patientName.hashCode ^
        patientPhone.hashCode ^
        baseFee.hashCode ^
        reason.hashCode ^
        patientAddress.hashCode ^
        assignedStaffName.hashCode ^
        assignedStaffUid.hashCode ^
        assignedStaffPhone.hashCode ^
        status.hashCode ^
        paymentStatus.hashCode ^
        secretOtp.hashCode ^
        isFeedBackGiven.hashCode;
  }
}
