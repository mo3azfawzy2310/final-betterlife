// doctor_model.dart
class DoctorModel {
  final int id;
  final String name;
  final String userName;
  final String phone;
  final String speciality;
  final String pictureUrl;
  final double rate;
  final String? bio;
  final double newVisitPrice;
  final double followUpVisitPrice;
  final List<int> workingDays;
  final String startTime;
  final String endTime;
  final int appointmentDuration;

  DoctorModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.phone,
    required this.speciality,
    required this.pictureUrl,
    required this.rate,
    this.bio,
    required this.newVisitPrice,
    required this.followUpVisitPrice,
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.appointmentDuration,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['id'],
      name: json['name'],
      userName: json['userName'] ?? '',
      phone: json['phone'] ?? '',
      speciality: json['speciality'] ?? '',
      pictureUrl: json['pictureUrl'] ?? '',
      rate: (json['rate'] as num).toDouble(),
      bio: json['bio'],
      newVisitPrice: (json['newVisitPrice'] as num).toDouble(),
      followUpVisitPrice: (json['followUpVisitPrice'] as num).toDouble(),
      workingDays: List<int>.from(json['workingDays'] ?? []),
      startTime: json['startTime'],
      endTime: json['endTime'],
      appointmentDuration: json['appointmentDuration'],
    );
  }
}

// health_article_model.dart
class HealthArticleModel {
  final String id;
  final String date;
  final String diagnoses;
  final String prescription;
  final String speciality;
  final String doctorName;
  final String patientName;
  final List<LapTestModel> lapTests;
  final List<RadiationModel> radiation;

  HealthArticleModel({
    required this.id,
    required this.date,
    required this.diagnoses,
    required this.prescription,
    required this.speciality,
    required this.doctorName,
    required this.patientName,
    required this.lapTests,
    required this.radiation,
  });

  factory HealthArticleModel.fromJson(Map<String, dynamic> json) {
    return HealthArticleModel(
      id: json['id'],
      date: json['date'],
      diagnoses: json['diagnoses'],
      prescription: json['prescription'],
      speciality: json['speciality'],
      doctorName: json['doctorName'],
      patientName: json['patientName'],
      lapTests: (json['lapTests'] as List<dynamic>).map((e) => LapTestModel.fromJson(e)).toList(),
      radiation: (json['radiation'] as List<dynamic>).map((e) => RadiationModel.fromJson(e)).toList(),
    );
  }
}

class LapTestModel {
  final String id;
  final String testType;
  final String testDate;
  final String testResult;
  final int testUnits;
  final String comments;
  final String lapName;
  final num referenceRange;

  LapTestModel({
    required this.id,
    required this.testType,
    required this.testDate,
    required this.testResult,
    required this.testUnits,
    required this.comments,
    required this.lapName,
    required this.referenceRange,
  });

  factory LapTestModel.fromJson(Map<String, dynamic> json) {
    return LapTestModel(
      id: json['id'],
      testType: json['testType'],
      testDate: json['testDate'],
      testResult: json['testResult'],
      testUnits: json['testUnits'],
      comments: json['comments'],
      lapName: json['lapName'],
      referenceRange: json['referenceRange'],
    );
  }
}

class RadiationModel {
  final String id;
  final String imagingType;
  final String imagingDate;
  final String imagingResult;
  final String comments;
  final String medicalRecordId;

  RadiationModel({
    required this.id,
    required this.imagingType,
    required this.imagingDate,
    required this.imagingResult,
    required this.comments,
    required this.medicalRecordId,
  });

  factory RadiationModel.fromJson(Map<String, dynamic> json) {
    return RadiationModel(
      id: json['id'],
      imagingType: json['imagingType'],
      imagingDate: json['imagingDate'],
      imagingResult: json['imagingResult'],
      comments: json['comments'],
      medicalRecordId: json['medicalRecordId'],
    );
  }
}
