abstract class EndpointConstants {
  static const String baseUrl = "http://betterlife.runasp.net/api/";
  static const String login = "Authentication/login";
  static const String register = "Patient/AddPatient";
  
  // Google Authentication endpoints
  static const String googleLogin = "Authentication/google-login";
  static const String googleSignup = "Authentication/RegisterPatientByGoogle";
  
  // Patient endpoints
  static const String getPatientById = "Patient/Patient";
  static const String getPatientByUsername = "Patient/Patient/userName";
  static const String addPatient = "Patient/AddPatient";
  static const String updatePatient = "Patient/UpdatePatient";
  static const String getMedicalRecord = "Patient/MedicalRecord";
  static const String getRadiation = "Patient/Radiation";
  
  // Notification endpoints
  static const String getAllNotifications = "Patient/Notifications";
  static const String getNotificationById = "Patient/Notification";
  static const String readNotification = "Patient/ReadNotification";
  static const String deleteNotification = "Patient/DeleteNotification";
  
  // Doctor endpoints
  static const String getDoctor = "Patient/Doctor/id";
  static const String getAllDoctors = "Patient/Doctors";
  static const String getFavoriteDoctors = "Patient/FavoriteDoctors";
  static const String addFavoriteDoctor = "Patient/AddFavoriteDoctor";
  static const String removeFavoriteDoctor = "Patient/RemoveDoctorFromFavorites";
  static const String rateDoctor = "Patient/RateDoctor";
  
  // Appointment endpoints
  static const String getPatientAppointments = "Patient/Appointments"; 
  static const String getAppointmentById = "Patient/Appointment";
  static const String getAvailableDays = "Patient/AvailableDays";
  static const String getAvailableTimes = "Patient/AvailableTimes";
  static const String createAppointment = "Patient/CreateAppointment";
  static const String updateAppointment = "Patient/Patient/UpdateAppointment";
  static const String cancelAppointment = "Patient/CancelAppointment";
}
