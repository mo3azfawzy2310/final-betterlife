class RegisterRequestModel {
  final String displayName;
  final String email;
  final String password;
  final String phoneNumber;
  final String userName;
  final String role;

  final String name;
  final String birthDate;
  final String gender;
  final String address;

  RegisterRequestModel({
    required this.displayName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.userName,
    required this.role,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "userName": userName,
        "role": role,
        "name": name,
        "birthDate": birthDate,
        "gender": gender,
        "address": address,
      };
}
