class NotificationModel {
  final int? id;
  final int? patientId;
  final String? title;
  final String? message;
  final String? date;
  final bool? isRead;
  final String? type;

  NotificationModel({
    this.id,
    this.patientId,
    this.title,
    this.message,
    this.date,
    this.isRead,
    this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      patientId: json['patientId'],
      title: json['title'],
      message: json['message'],
      date: json['date'],
      isRead: json['isRead'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'title': title,
      'message': message,
      'date': date,
      'isRead': isRead,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'NotificationModel(id: $id, title: $title, isRead: $isRead)';
  }
} 