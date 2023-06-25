import 'dart:convert';

class FeedBackModel {
  String feedBackId;
  String patientUid;
  String patientName;
  String patientPhone;
  String staffUid;
  String staffName;
  String staffPhone;
  String feedBack;
  String dateOfFeedback;
  String feedbackAppointmentId;
  FeedBackModel({
    required this.feedBackId,
    required this.patientUid,
    required this.patientName,
    required this.patientPhone,
    required this.staffUid,
    required this.staffName,
    required this.staffPhone,
    required this.feedBack,
    required this.dateOfFeedback,
    required this.feedbackAppointmentId,
  });

  FeedBackModel copyWith({
    String? feedBackId,
    String? patientUid,
    String? patientName,
    String? patientPhone,
    String? staffUid,
    String? staffName,
    String? staffPhone,
    String? feedBack,
    String? dateOfFeedback,
    String? feedbackAppointmentId,
  }) {
    return FeedBackModel(
      feedBackId: feedBackId ?? this.feedBackId,
      patientUid: patientUid ?? this.patientUid,
      patientName: patientName ?? this.patientName,
      patientPhone: patientPhone ?? this.patientPhone,
      staffUid: staffUid ?? this.staffUid,
      staffName: staffName ?? this.staffName,
      staffPhone: staffPhone ?? this.staffPhone,
      feedBack: feedBack ?? this.feedBack,
      dateOfFeedback: dateOfFeedback ?? this.dateOfFeedback,
      feedbackAppointmentId:
          feedbackAppointmentId ?? this.feedbackAppointmentId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'feedBackId': feedBackId});
    result.addAll({'patientUid': patientUid});
    result.addAll({'patientName': patientName});
    result.addAll({'patientPhone': patientPhone});
    result.addAll({'staffUid': staffUid});
    result.addAll({'staffName': staffName});
    result.addAll({'staffPhone': staffPhone});
    result.addAll({'feedBack': feedBack});
    result.addAll({'dateOfFeedback': dateOfFeedback});
    result.addAll({'feedbackAppointmentId': feedbackAppointmentId});

    return result;
  }

  factory FeedBackModel.fromMap(Map<String, dynamic> map) {
    return FeedBackModel(
      feedBackId: map['feedBackId'] ?? '',
      patientUid: map['patientUid'] ?? '',
      patientName: map['patientName'] ?? '',
      patientPhone: map['patientPhone'] ?? '',
      staffUid: map['staffUid'] ?? '',
      staffName: map['staffName'] ?? '',
      staffPhone: map['staffPhone'] ?? '',
      feedBack: map['feedBack'] ?? '',
      dateOfFeedback: map['dateOfFeedback'] ?? '',
      feedbackAppointmentId: map['feedbackAppointmentId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedBackModel.fromJson(String source) =>
      FeedBackModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedBackModel(feedBackId: $feedBackId, patientUid: $patientUid, patientName: $patientName, patientPhone: $patientPhone, staffUid: $staffUid, staffName: $staffName, staffPhone: $staffPhone, feedBack: $feedBack, dateOfFeedback: $dateOfFeedback, feedbackAppointmentId: $feedbackAppointmentId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedBackModel &&
        other.feedBackId == feedBackId &&
        other.patientUid == patientUid &&
        other.patientName == patientName &&
        other.patientPhone == patientPhone &&
        other.staffUid == staffUid &&
        other.staffName == staffName &&
        other.staffPhone == staffPhone &&
        other.feedBack == feedBack &&
        other.dateOfFeedback == dateOfFeedback &&
        other.feedbackAppointmentId == feedbackAppointmentId;
  }

  @override
  int get hashCode {
    return feedBackId.hashCode ^
        patientUid.hashCode ^
        patientName.hashCode ^
        patientPhone.hashCode ^
        staffUid.hashCode ^
        staffName.hashCode ^
        staffPhone.hashCode ^
        feedBack.hashCode ^
        dateOfFeedback.hashCode ^
        feedbackAppointmentId.hashCode;
  }
}
