class UserModel {
  final String displayName;
  final String email;
  final String token;
  final int? patientId;

  UserModel({
    required this.displayName,
    required this.email,
    required this.token,
    this.patientId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json['displayName'] ?? '',
      email: json['email'] ?? '',
      token: json['token'] ?? '',
      patientId: json['patientId'] ?? json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'token': token,
      'patientId': patientId,
    };
  }
}
