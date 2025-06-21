class AppointmentModel {
  final String id;
  final String appointmentDateTime;
  final bool isBooked;
  final String? notes;
  final String type;
  final String? status;
  final String patientName;
  final String doctorName;
  final int doctorId;
  final String? reason;

  AppointmentModel({
    required this.id,
    required this.appointmentDateTime,
    required this.isBooked,
    this.notes,
    required this.type,
    this.status,
    required this.patientName,
    required this.doctorName,
    this.doctorId = 0,
    this.reason,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] ?? '',
      appointmentDateTime: json['appointmentDateTime'] ?? '',
      isBooked: json['isBooked'] ?? false,
      notes: json['notes'],
      type: json['type'] ?? '',
      status: json['status'],
      patientName: json['patientName'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorId: json['doctorId'] ?? 0,
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'appointmentDateTime': appointmentDateTime,
      'isBooked': isBooked,
      'notes': notes,
      'type': type,
      'status': status,
      'patientName': patientName,
      'doctorName': doctorName,
      'doctorId': doctorId,
      'reason': reason,
    };
  }
}

class AvailableDay {
  final String date;
  final String dayName;
  final String dateString;
  final bool isAvailable;

  AvailableDay({
    required this.date,
    required this.dayName,
    required this.dateString,
    required this.isAvailable,
  });

  factory AvailableDay.fromJson(Map<String, dynamic> json) {
    return AvailableDay(
      date: json['date'] ?? '',
      dayName: json['dayName'] ?? '',
      dateString: json['dateString'] ?? '',
      isAvailable: json['isAvailable'] ?? false,
    );
  }
} 