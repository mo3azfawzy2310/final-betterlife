class RadiationModel {
  final String? id;
  final String? patientId;
  final String? type;
  final String? date;
  final String? description;
  final String? doctorName;
  final String? hospital;
  final String? fileUrl;
  final String? result;

  RadiationModel({
    this.id,
    this.patientId,
    this.type,
    this.date,
    this.description,
    this.doctorName,
    this.hospital,
    this.fileUrl,
    this.result,
  });

  factory RadiationModel.fromJson(Map<String, dynamic> json) {
    return RadiationModel(
      id: json['id'],
      patientId: json['patientId'],
      type: json['type'],
      date: json['date'],
      description: json['description'],
      doctorName: json['doctorName'],
      hospital: json['hospital'],
      fileUrl: json['fileUrl'],
      result: json['result'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'type': type,
      'date': date,
      'description': description,
      'doctorName': doctorName,
      'hospital': hospital,
      'fileUrl': fileUrl,
      'result': result,
    };
  }

  @override
  String toString() {
    return 'RadiationModel(id: $id, type: $type, date: $date)';
  }
} 