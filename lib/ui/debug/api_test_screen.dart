import 'package:flutter/material.dart';
import 'package:better_life/core/services/google_auth_service.dart';
import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/core/services/appointment_service.dart';
import 'package:better_life/core/services/doctor_service.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  final TextEditingController _idTokenController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _patientIdController = TextEditingController();
  final TextEditingController _doctorIdController = TextEditingController();
  final TextEditingController _notificationIdController = TextEditingController();
  final TextEditingController _medicalRecordIdController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  String _testResults = '';

  @override
  void initState() {
    super.initState();
    // Pre-fill with your test data
    _idTokenController.text = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IjFiYjc3NGJkODcyOWVhMzhlOWMyZmUwYzY0ZDJjYTk0OGJmNjZmMGYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI5ODQ5NTY4MDYyMjAtdnQ3dmI5cjZhcWpvN3VoampydTVlcDVyNXFlNGE1dm4uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI5ODQ5NTY4MDYyMjAtdnQ3dmI5cjZhcWpvN3VoampydTVlcDVyNXFlNGE1dm4uYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTgxNzg3NDUzMDA4ODY5NzY2MzAiLCJlbWFpbCI6ImJvZHllbHNheWVkNTIwQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJhdF9oYXNoIjoiQnVZQndaRW9jVGVLOWcxSVpzdkxrdyIsIm5hbWUiOiJBYmQgRWxyYWhtYW4gRWxzYXllZCIsInBpY3R1cmUiOiJodHRwczovL2xoMy5nb29nbGV1c2VyY29udGVudC5jb20vYS9BQ2c4b2NJTU9Zb1BsZmpjS25xb1MweWlDS3NhYmIxLUp2cGRpOWxBZVo5Mko4NEVGSGxkTHc9czk2LWMiLCJnaXZlbl9uYW1lIjoiQWJkIEVscmFobWFuIiwiZmFtaWx5X25hbWUiOiJFbHNheWVkIiwiaWF0IjoxNzUwMzU2MTg4LCJleHAiOjE3NTAzNTk3ODh9.TmamZ9Y2WEROf8p0VgUX2jz2MVVPcg0Vwhu7eXzB6NNVbQr8CEUI-Pp9SnPUtZgiVopGI2IOuflNjqo9lC21jpAfHnQrOCtcuibw5BPNn63WNzi7c8FKGOUbOzE-gYqFmFoPMamdD6bLTFrzabUMjLNxgJNiKa4L_9ZKLzTicc7MDtMeFYnQjDgmQgWj6SlDpHP8XYPfGQDu59ziaSxl8UIXY-EuLlnZcYmzKNWSGvRhpfZzoIC0W7O_wuFWH4KnU2Ub7HkIzOYKZsuogerNisHnP4AvbHlLwFW7pff7PtBaPzVmjt2Q6hKKbZSHCuRmxR_mzo2qIlz0Zehtjeh_kg';
    _usernameController.text = 'mm';
    _patientIdController.text = '3';
    _doctorIdController.text = '21';
    _notificationIdController.text = '2';
    _medicalRecordIdController.text = '3fa85f64-5717-4562-b3fc-2c963f66af14';
    _ratingController.text = '5';
  }

  void _addResult(String result) {
    setState(() {
      _testResults += '$result\n\n';
    });
  }

  // Authentication tests
  Future<void> _testGoogleLogin() async {
    try {
      _addResult('🔄 Testing Google Login...');
      final googleAuthService = GoogleAuthService();
      final user = await googleAuthService.googleLogin(_idTokenController.text);
      _addResult('✅ Google Login Success:\n${user.toJson()}');
    } catch (e) {
      _addResult('❌ Google Login Failed:\n$e');
    }
  }

  Future<void> _testGoogleSignup() async {
    try {
      _addResult('🔄 Testing Google Signup...');
      final googleAuthService = GoogleAuthService();
      final user = await googleAuthService.googleSignup(_idTokenController.text, _usernameController.text);
      _addResult('✅ Google Signup Success:\n${user.toJson()}');
    } catch (e) {
      _addResult('❌ Google Signup Failed:\n$e');
    }
  }

  // Patient tests
  Future<void> _testGetPatientById() async {
    try {
      _addResult('🔄 Testing Get Patient by ID...');
      final patientId = int.tryParse(_patientIdController.text) ?? 1;
      final patient = await UserService.getPatientById(patientId);
      _addResult('✅ Get Patient by ID Success:\n${patient.toJson()}');
    } catch (e) {
      _addResult('❌ Get Patient by ID Failed:\n$e');
    }
  }

  Future<void> _testGetPatientByUsername() async {
    try {
      _addResult('🔄 Testing Get Patient by Username...');
      final patient = await UserService.getPatientByUsername(_usernameController.text);
      _addResult('✅ Get Patient by Username Success:\n${patient.toJson()}');
    } catch (e) {
      _addResult('❌ Get Patient by Username Failed:\n$e');
    }
  }

  Future<void> _testGetMedicalRecords() async {
    try {
      _addResult('🔄 Testing Get Medical Records...');
      final patientId = int.tryParse(_medicalRecordIdController.text) ?? 1;
      final records = await UserService.getMedicalRecords(patientId);
      _addResult('✅ Get Medical Records Success:\n${records.map((r) => r.toJson()).toList()}');
    } catch (e) {
      _addResult('❌ Get Medical Records Failed:\n$e');
    }
  }

  Future<void> _testGetRadiationRecords() async {
    try {
      _addResult('🔄 Testing Get Radiation Records...');
      final patientId = int.tryParse(_medicalRecordIdController.text) ?? 1;
      final records = await UserService.getRadiationRecords(patientId);
      _addResult('✅ Get Radiation Records Success:\n${records.map((r) => r.toJson()).toList()}');
    } catch (e) {
      _addResult('❌ Get Radiation Records Failed:\n$e');
    }
  }

  // Notification tests
  Future<void> _testGetAllNotifications() async {
    try {
      _addResult('🔄 Testing Get All Notifications...');
      final patientId = int.tryParse(_patientIdController.text) ?? 2;
      final notifications = await UserService.getAllNotifications(patientId);
      _addResult('✅ Get All Notifications Success:\n${notifications.map((n) => n.toJson()).toList()}');
    } catch (e) {
      _addResult('❌ Get All Notifications Failed:\n$e');
    }
  }

  Future<void> _testGetNotificationById() async {
    try {
      _addResult('🔄 Testing Get Notification by ID...');
      final notificationId = int.tryParse(_notificationIdController.text) ?? 2;
      final notification = await UserService.getNotificationById(notificationId);
      _addResult('✅ Get Notification by ID Success:\n${notification.toJson()}');
    } catch (e) {
      _addResult('❌ Get Notification by ID Failed:\n$e');
    }
  }

  Future<void> _testReadNotification() async {
    try {
      _addResult('🔄 Testing Read Notification...');
      final notificationId = int.tryParse(_notificationIdController.text) ?? 1;
      final success = await UserService.readNotification(notificationId);
      _addResult('✅ Read Notification Success: $success');
    } catch (e) {
      _addResult('❌ Read Notification Failed:\n$e');
    }
  }

  Future<void> _testDeleteNotification() async {
    try {
      _addResult('🔄 Testing Delete Notification...');
      final notificationId = int.tryParse(_notificationIdController.text) ?? 1;
      final success = await UserService.deleteNotification(notificationId);
      _addResult('✅ Delete Notification Success: $success');
    } catch (e) {
      _addResult('❌ Delete Notification Failed:\n$e');
    }
  }

  // Doctor tests
  Future<void> _testGetDoctor() async {
    try {
      _addResult('🔄 Testing Get Doctor...');
      final doctorService = DoctorService();
      final doctorId = int.tryParse(_doctorIdController.text) ?? 21;
      final doctor = await doctorService.getDoctor(doctorId);
      if (doctor != null) {
        _addResult('✅ Get Doctor Success:\n${doctor.toJson()}');
      } else {
        _addResult('❌ Get Doctor Failed: Doctor not found');
      }
    } catch (e) {
      _addResult('❌ Get Doctor Failed:\n$e');
    }
  }

  Future<void> _testGetAllDoctors() async {
    try {
      _addResult('🔄 Testing Get All Doctors...');
      final doctorService = DoctorService();
      final doctors = await doctorService.getAllDoctors();
      _addResult('✅ Get All Doctors Success:\n${doctors.map((d) => d.toJson()).toList()}');
    } catch (e) {
      _addResult('❌ Get All Doctors Failed:\n$e');
    }
  }

  Future<void> _testGetFavoriteDoctors() async {
    try {
      _addResult('🔄 Testing Get Favorite Doctors...');
      final doctorService = DoctorService();
      final patientId = int.tryParse(_patientIdController.text) ?? 3;
      final doctors = await doctorService.getFavoriteDoctors(patientId);
      _addResult('✅ Get Favorite Doctors Success:\n${doctors.map((d) => d.toJson()).toList()}');
    } catch (e) {
      _addResult('❌ Get Favorite Doctors Failed:\n$e');
    }
  }

  Future<void> _testAddFavoriteDoctor() async {
    try {
      _addResult('🔄 Testing Add Favorite Doctor...');
      final doctorService = DoctorService();
      final doctorId = int.tryParse(_doctorIdController.text) ?? 4;
      final patientId = int.tryParse(_patientIdController.text) ?? 3;
      final success = await doctorService.addFavoriteDoctor(doctorId, patientId);
      _addResult('✅ Add Favorite Doctor Success: $success');
    } catch (e) {
      _addResult('❌ Add Favorite Doctor Failed:\n$e');
    }
  }

  Future<void> _testRemoveFavoriteDoctor() async {
    try {
      _addResult('🔄 Testing Remove Favorite Doctor...');
      final doctorService = DoctorService();
      final doctorId = int.tryParse(_doctorIdController.text) ?? 3;
      final patientId = int.tryParse(_patientIdController.text) ?? 3;
      final success = await doctorService.removeFavoriteDoctor(doctorId, patientId);
      _addResult('✅ Remove Favorite Doctor Success: $success');
    } catch (e) {
      _addResult('❌ Remove Favorite Doctor Failed:\n$e');
    }
  }

  Future<void> _testRateDoctor() async {
    try {
      _addResult('🔄 Testing Rate Doctor...');
      final doctorId = int.tryParse(_doctorIdController.text) ?? 21;
      final rating = int.tryParse(_ratingController.text) ?? 5;
      final success = await UserService.rateDoctor(doctorId, rating);
      _addResult('✅ Rate Doctor Success: $success');
    } catch (e) {
      _addResult('❌ Rate Doctor Failed:\n$e');
    }
  }

  // Appointment tests
  Future<void> _testGetAppointments() async {
    try {
      _addResult('🔄 Testing Get Appointments...');
      final appointmentService = AppointmentService();
      final patientId = int.tryParse(_patientIdController.text) ?? 3;
      final appointments = await appointmentService.getAppointments(patientId);
      _addResult('✅ Get Appointments Success:\n${appointments.map((a) => a.toJson()).toList()}');
    } catch (e) {
      _addResult('❌ Get Appointments Failed:\n$e');
    }
  }

  Future<void> _testCurrentUser() async {
    try {
      _addResult('🔄 Testing Current User...');
      final user = await UserService.getCurrentUser();
      if (user != null) {
        _addResult('✅ Current User:\n${user.toJson()}');
      } else {
        _addResult('❌ No current user found');
      }
    } catch (e) {
      _addResult('❌ Get Current User Failed:\n$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Test Screen'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input fields
            TextField(
              controller: _idTokenController,
              decoration: const InputDecoration(
                labelText: 'Google ID Token',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _patientIdController,
                    decoration: const InputDecoration(
                      labelText: 'Patient ID',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _doctorIdController,
                    decoration: const InputDecoration(
                      labelText: 'Doctor ID',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _notificationIdController,
                    decoration: const InputDecoration(
                      labelText: 'Notification ID',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _medicalRecordIdController,
                    decoration: const InputDecoration(
                      labelText: 'Medical Record ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Rating (1-5)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            
            // Test buttons - Authentication
            const Text('Authentication', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGoogleLogin,
                    child: const Text('Test Google Login'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGoogleSignup,
                    child: const Text('Test Google Signup'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Test buttons - Patient
            const Text('Patient', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetPatientById,
                    child: const Text('Get Patient by ID'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetPatientByUsername,
                    child: const Text('Get Patient by Username'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetMedicalRecords,
                    child: const Text('Get Medical Records'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetRadiationRecords,
                    child: const Text('Get Radiation Records'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Test buttons - Notifications
            const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetAllNotifications,
                    child: const Text('Get All Notifications'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetNotificationById,
                    child: const Text('Get Notification by ID'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testReadNotification,
                    child: const Text('Read Notification'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testDeleteNotification,
                    child: const Text('Delete Notification'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Test buttons - Doctors
            const Text('Doctors', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetDoctor,
                    child: const Text('Get Doctor'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetAllDoctors,
                    child: const Text('Get All Doctors'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetFavoriteDoctors,
                    child: const Text('Get Favorites'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testAddFavoriteDoctor,
                    child: const Text('Add Favorite'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testRemoveFavoriteDoctor,
                    child: const Text('Remove Favorite'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testRateDoctor,
                    child: const Text('Rate Doctor'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Test buttons - Appointments & User
            const Text('Appointments & User', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testGetAppointments,
                    child: const Text('Get Appointments'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _testCurrentUser,
                    child: const Text('Current User'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _testResults = '';
                });
              },
              child: const Text('Clear Results'),
            ),
            const SizedBox(height: 16),
            
            // Results
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _testResults.isEmpty ? 'Test results will appear here...' : _testResults,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 