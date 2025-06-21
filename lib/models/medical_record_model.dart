class MedicalRecordModel {
  final String? id;
  final String? patientId;
  final String? title;
  final String? description;
  final String? date;
  final String? doctorName;
  final String? hospital;
  final String? fileUrl;
  final String? type;

  MedicalRecordModel({
    this.id,
    this.patientId,
    this.title,
    this.description,
    this.date,
    this.doctorName,
    this.hospital,
    this.fileUrl,
    this.type,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'],
      patientId: json['patientId'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      doctorName: json['doctorName'],
      hospital: json['hospital'],
      fileUrl: json['fileUrl'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'title': title,
      'description': description,
      'date': date,
      'doctorName': doctorName,
      'hospital': hospital,
      'fileUrl': fileUrl,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'MedicalRecordModel(id: $id, title: $title, date: $date)';
  }
} 