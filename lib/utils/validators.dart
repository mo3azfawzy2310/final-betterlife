
class Validators {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static bool isValidPhone(String phone) {
    final cleaned = phone.trim();
    return RegExp(r'^\d{6,12}$').hasMatch(cleaned);
  }
}
