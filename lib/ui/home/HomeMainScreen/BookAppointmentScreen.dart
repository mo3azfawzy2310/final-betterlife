import 'package:better_life/core/services/appointment_service.dart';
import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/home/homeScreen.dart';
import 'package:better_life/ui/logic/appointment/appointment_cubit.dart';
import 'package:better_life/ui/utils/dialog_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookAppointmentScreen extends StatefulWidget {
  static const String routeName = '/book-appointment';
  final DoctorModel doctor;
  final Function()? onBookingComplete;

  const BookAppointmentScreen({
    Key? key,
    required this.doctor,
    this.onBookingComplete,
  }) : super(key: key);

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  final AppointmentService _appointmentService = AppointmentService();
  TextEditingController _reasonController = TextEditingController();
  int? currentPatientId;
  
  bool isLoading = false;
  bool isLoadingTimes = false;
  
  // List of available dates
  List<String> _availableDates = [];
  List<String> _availableTimes = [];
  
  String? selectedDate;
  String? selectedTime;
  
  List<Map<String, dynamic>> availableDays = [];
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadAvailableDaysForDoctor();
  }
  
  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }
  
  Future<void> _loadUserData() async {
    try {
      final user = await UserService.getCurrentUser();
      
      if (user != null && user.patientId != null) {
        // User is properly authenticated
        if (mounted) {
          setState(() {
            currentPatientId = user.patientId;
            print('📱 User loaded successfully. PatientId: ${user.patientId}');
          });
        }
      } else {
        // For development/testing: Create a test user with ID 1
        print('⚠️ No authenticated user found. Using test user with ID 1 for development.');
        if (mounted) {
          setState(() {
            currentPatientId = 1; // Use a test patient ID
          });
        }
      }
    } catch (e) {
      print('❌ Error loading user data: $e');
      // For development/testing: Create a test user with ID 1
      if (mounted) {
        setState(() {
          currentPatientId = 1;
          print('⚠️ Using test user with ID 1 for development due to error');
        });
        
        // Only show error in debug mode, not for end users
        assert(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading user data: $e. Using test user instead.'))
          );
          return true;
        }());
      }
    }
  }
  
  // Load available days for this doctor
  Future<void> _loadAvailableDaysForDoctor() async {
    try {
      final availableDays = await AppointmentService().getAvailableDays(widget.doctor.id);
      
      if (availableDays.isNotEmpty) {
        setState(() {
          _availableDates = availableDays
              .where((day) => day['isAvailable'] == true)
              .map((day) => day['date'].toString())
              .toList();
          
          print('📆 Available dates: $_availableDates');
        });
      } else {
        // If no available days returned, provide some defaults
        final now = DateTime.now();
        setState(() {
          _availableDates = List.generate(
            7, 
            (index) => DateTime(now.year, now.month, now.day + index + 1).toIso8601String().split('T')[0]
          );
        });
        print('📆 Using default dates: $_availableDates');
      }
    } catch (e) {
      print('❌ Error loading available days: $e');
      // Provide default dates on error
      final now = DateTime.now();
      setState(() {
        _availableDates = List.generate(
          7, 
          (index) => DateTime(now.year, now.month, now.day + index + 1).toIso8601String().split('T')[0]
        );
      });
    }
  }
  
  // Check if the date is available for booking
  bool _isDateAvailable(String date) {
    // If we don't have available dates yet, allow selection
    if (_availableDates.isEmpty) return true;
    
    // Otherwise, check if the date is in the available dates list
    return _availableDates.contains(date);
  }
  
  // Custom date picker that only shows available dates
  Future<void> _selectDate() async {
    final now = DateTime.now();
    final firstDate = now;
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate: (DateTime day) {
        // Format the date to match the available dates format
        final formattedDate = day.toIso8601String().split('T')[0];
        return _isDateAvailable(formattedDate);
      },
    );
    
    if (picked != null) {
      setState(() {
        selectedDate = picked.toIso8601String();
        selectedTime = null; // Reset time when date changes
      });
      
      // Load available times for the selected date
      _loadAvailableTimesForDate(selectedDate!);
    }
  }
  
  // Load available times for a specific date
  Future<void> _loadAvailableTimesForDate(String date) async {
    try {
      final List<String> times = await AppointmentService().getAvailableTimes(
        widget.doctor.id,
        date,
      );
      
      setState(() {
        _availableTimes = times;
      });
      
      print('⏰ Available times for $date: $_availableTimes');
    } catch (e) {
      print('❌ Error loading available times: $e');
    }
  }
  
  Future<void> _loadAvailableTimes(String date) async {
    setState(() {
      isLoadingTimes = true;
      _availableTimes = [];
      selectedTime = null;
    });
    
    try {
      print('🕒 Loading available times for doctor ID: ${widget.doctor.id} on date: $date');
      final times = await _appointmentService.getAvailableTimes(widget.doctor.id, date);
      print('🕒 Available times received: $times');
      
      if (mounted) {
        setState(() {
          _availableTimes = times;
          isLoadingTimes = false;
        });
        
        if (times.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No available time slots for this date'))
          );
        }
      }
    } catch (e) {
      print('❌ Error loading available times: $e');
      if (mounted) {
        setState(() {
          isLoadingTimes = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading available times: $e')),
        );
      }
    }
  }
  
  String _formatAppointmentDateTime(String date, String time) {
    try {
      // Parse the date string into a DateTime object
      final DateTime parsedDate = DateTime.parse(date);
      
      // Parse time components
      final List<String> timeParts = time.split(':');
      final int hour = int.parse(timeParts[0]);
      final int minute = int.parse(timeParts[1]);
      
      // Create a new DateTime with both date and time components
      final dateTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        hour,
        minute,
      );
      
      // Return ISO8601 format that the API expects
      final formattedDateTime = dateTime.toIso8601String();
      print('📆 Formatted appointment date/time: $formattedDateTime');
      return formattedDateTime;
    } catch (e) {
      print('❌ Error formatting date/time: $e');
      return '${date}T${time}:00';
    }
  }
  
  Future<void> _bookAppointment() async {
    if (currentPatientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need to be logged in to book an appointment'))
      );
      return;
    }
    
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date and time'))
      );
      return;
    }
    
    if (_reasonController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a reason for the appointment'))
      );
      return;
    }
    
    // Convert date and time to the format expected by the API
    final dateTime = _formatAppointmentDateTime(selectedDate!, selectedTime!);
    
    // Debug info
    print('📋 Booking appointment with:');
    print('  - Patient ID: $currentPatientId');
    print('  - Doctor ID: ${widget.doctor.id}');
    print('  - Date: $selectedDate');
    print('  - Time: $selectedTime');
    print('  - Formatted Date/Time: $dateTime');
    print('  - Reason: ${_reasonController.text.trim()}');
    
    DialogUtils.showConfirmDialog(
      context: context, 
      title: 'Confirm Appointment', 
      message: 'Are you sure you want to book an appointment with Dr. ${widget.doctor.name} on ${_formatDisplayDate(selectedDate!)} at $selectedTime?',
      onConfirm: () {
        // Show loading indicator
        setState(() {
          isLoading = true;
        });
        
        // Create a simple request object
        final request = {
          'patientId': currentPatientId!,
          'doctorId': widget.doctor.id,
          'appointmentDateTime': dateTime,
          'reason': _reasonController.text.trim()
        };
        
        // Make a direct API call
        _createAppointmentDirectly(request);
      }
    );
  }
  
  Future<void> _createAppointmentDirectly(Map<String, dynamic> request) async {
    try {
      final dio = Dio();
      dio.options.baseUrl = 'http://betterlife.runasp.net/api/';
      
      final response = await dio.post(
        'Patient/CreateAppointment',
        data: request,
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
      );
      
      print('✅ Appointment booking response status: ${response.statusCode}');
      print('✅ Appointment booking response data: ${response.data}');
      
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 302) {
        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appointment request sent successfully! It will appear in your schedule after approval.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 5),
            ),
          );
          
          // Refresh appointments in the cubit
          if (currentPatientId != null) {
            try {
              // Get the formatted date time
              final formattedDateTime = _getFormattedDateTime();
              
              // Create a proper request object for the cubit
              final bookRequest = BookAppointmentRequest(
                patientId: currentPatientId!,
                doctorId: widget.doctor.id,
                appointmentDateTime: formattedDateTime,
                reason: _reasonController.text,
              );
              
              // Use the cubit to refresh appointments
              context.read<AppointmentCubit>().getPatientAppointments(currentPatientId!);
            } catch (e) {
              print('❌ Error refreshing appointments: $e');
            }
          }
          
          // Navigate back to previous screen
          if (mounted) {
            if (widget.onBookingComplete != null) {
              widget.onBookingComplete!();
            } else {
              Navigator.of(context).pop();
            }
          }
        }
      } else {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to book appointment: ${response.statusCode}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('❌ Error booking appointment: $e');
      
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error booking appointment: $e')),
        );
      }
    }
  }

  // Helper method to verify if appointment was created
  Future<void> _verifyAppointmentCreated() async {
    if (currentPatientId == null || !mounted) return;
    
    try {
      final exists = await _appointmentService.checkAppointmentExists(
        currentPatientId!, 
        widget.doctor.id
      );
      
      if (!mounted) return;
      
      if (exists) {
        // Refresh appointments in the cubit
        context.read<AppointmentCubit>().getPatientAppointments(currentPatientId!);
        
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment confirmed! Check your schedule.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 5),
          ),
        );
        
        // Navigate back safely
        if (mounted) {
          Navigator.of(context).pop();
        }
      } else {
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Appointment request sent. It may take some time to appear in your schedule.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 5),
          ),
        );
        
        // Navigate back safely
        if (mounted) {
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      print('❌ Error verifying appointment: $e');
      
      if (!mounted) return;
      
      // Navigate back safely
      Navigator.of(context).pop();
    }
  }

  // Helper method to get formatted date time
  String _getFormattedDateTime() {
    if (selectedDate == null || selectedTime == null) {
      return '';
    }
    return _formatAppointmentDateTime(selectedDate!, selectedTime!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: isLoading 
        ? const Center(child: CircularProgressIndicator()) 
        : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor info
              _buildDoctorInfo(),
              
              const SizedBox(height: 24),
              
              // Date selection
              _buildDateSection(),
              
              const SizedBox(height: 24),
              
              // Reason for appointment
              const Text(
                'Reason for Appointment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _reasonController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter reason for appointment',
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 32),
              
              // Book button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _bookAppointment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF199A8E),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
  
  Widget _buildDoctorInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: widget.doctor.pictureUrl != null ? 
              NetworkImage(widget.doctor.pictureUrl!) : 
              const AssetImage('assets/images/homeScreen/Doctor.png') as ImageProvider,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.doctor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.doctor.speciality,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'New Visit: \$${widget.doctor.newVisitPrice}',
                  style: const TextStyle(
                    color: Color(0xFF199A8E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Date & Time",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: _selectDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate == null 
                      ? 'Select a date' 
                      : _formatDisplayDate(selectedDate!),
                  style: TextStyle(
                    color: selectedDate == null ? Colors.grey : Colors.black,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        selectedDate == null
            ? const Text('Please select a date first',
                style: TextStyle(color: Colors.grey))
            : _buildTimeSelection(),
      ],
    );
  }
  
  String _formatDisplayDate(String isoDate) {
    try {
      final date = DateTime.parse(isoDate);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return isoDate;
    }
  }

  Widget _buildTimeSelection() {
    if (_availableTimes.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 12,
      children: _availableTimes.map((time) {
        final isSelected = selectedTime == time;
        return InkWell(
          onTap: () {
            setState(() {
              selectedTime = time;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
              border: Border.all(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
} 