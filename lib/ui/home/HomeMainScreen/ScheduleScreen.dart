import 'package:better_life/core/cach_data/app_shared_preferences.dart';
import 'package:better_life/core/services/user_service.dart';
import 'package:better_life/models/appointment_model.dart';
import 'package:better_life/models/user_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopSection.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/sheduleItem.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/status_tab_bar.dart';
import 'package:better_life/ui/logic/appointment/appointment_cubit.dart';
import 'package:better_life/ui/login_signup/loginScreen/loginScreen.dart';
import 'package:better_life/ui/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<ScheduleScreen>, WidgetsBindingObserver {
  int _selectedIndex = 0;
  final List<String> _tabs = ['All', 'Upcoming', 'Completed', 'Canceled'];
  int? _currentPatientId;
  bool _firstLoad = true;
  late TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 3, vsync: this);
    // We need context to access the cubit, so we do it after the first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came to foreground, refresh data
      _refreshAppointments();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // This will be called when the screen is shown due to navigation
    if (!_firstLoad) {
      _refreshAppointments();
    }
    _firstLoad = false;
  }

  Future<void> _refreshAppointments() async {
    print('🔄 Refreshing appointments in ScheduleScreen');
    if (_currentPatientId != null) {
      context.read<AppointmentCubit>().getPatientAppointments(_currentPatientId!);
    } else {
      _loadCurrentUserAndAppointments();
    }
  }

  Future<void> _loadCurrentUserAndAppointments() async {
    final user = await UserService.getCurrentUser();
    if (!mounted) return;

    final patientId = user?.patientId;

    if (patientId != null) {
      setState(() {
        _currentPatientId = patientId;
      });
      context.read<AppointmentCubit>().getPatientAppointments(patientId);
    } else if (user == null) {
      // Only show login dialog if user is completely null
      _showLoginRequiredDialog();
    } else {
      // User is logged in but missing patientId, let's try to fetch it
      await _fetchPatientId(user);
    }
  }
  
  Future<void> _fetchPatientId(UserModel user) async {
    try {
      // Create a more reliable displayName for lookup
      // Try different approaches to get patient ID
      UserModel? patientDetails;
      
      try {
        // First try: Check if the user is registered by username "zeiado" instead of "zeiad"
        patientDetails = await UserService.getPatientByUsername("zeiado");
      } catch (e) {
        // Second try: Use email for lookup if available
        if (user.email.isNotEmpty) {
          try {
            // Try to lookup patient by email via a different endpoint
            // This is a dummy solution since I don't know the exact API structure
            // You may need a custom endpoint or method for this
            final response = await UserService.getPatientByEmail(user.email);
            patientDetails = response;
          } catch (emailError) {
            // Email lookup failed too
            print('⚠️ Email lookup failed: $emailError');
          }
        }
      }
      
      if (patientDetails?.patientId != null) {
        // Create updated user with patientId
        final updatedUser = UserModel(
          displayName: user.displayName,
          email: user.email,
          token: user.token,
          patientId: patientDetails!.patientId,
        );
        
        // Save updated user model
        await AppPreferences().saveModel<UserModel>(
          'userModel',
          updatedUser,
          (u) => u.toJson(),
        );
        
        if (!mounted) return;
        
        setState(() {
          _currentPatientId = patientDetails!.patientId;
        });
        
        // Now fetch appointments with the retrieved patientId
        context.read<AppointmentCubit>().getPatientAppointments(patientDetails!.patientId!);
      } else {
        // Show form to associate account
        if (!mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your account needs to be associated with a patient profile. Please contact support.'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      
      // Show an error message but don't force login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error retrieving patient information: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showLoginRequiredDialog() {
    DialogUtils.showConfirmDialog(
      context: context,
      title: 'Login Required',
      message: 'You need to be logged in to view your appointments.',
      confirmText: 'Login',
      onConfirm: () {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      },
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Topsection(
                Notifications_Onpressed: () {}, // TODO: Implement navigation
                text: 'Schedule',
              ),
              Row(
                children: [
                  Expanded(
                    child: StatusTabBar(
                      tabs: _tabs,
                      selectedIndex: _selectedIndex,
                      onTabSelected: _onTabSelected,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: _refreshAppointments,
                    tooltip: 'Refresh appointments',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              Expanded(
                child:
                    BlocConsumer<AppointmentCubit, AppointmentState>(
                  listener: (context, state) {
                    if (state is AppointmentError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Error: ${state.message}'),
                            backgroundColor: Colors.red),
                      );
                    } else if (state is AppointmentActionSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.green),
                      );
                    } else if (state is AppointmentBooked && state.success) {
                      // Refresh appointments after successful booking
                      _refreshAppointments();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Appointment booked successfully!'),
                            backgroundColor: Colors.green),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AppointmentLoading &&
                        state is! AppointmentsLoaded) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Loading appointments...'),
                          ],
                        )
                      );
                    } else if (state is AppointmentsLoaded) {
                      final appointments = state.appointments;
                      return _buildAppointmentsList(appointments);
                    } else if (state is AppointmentError) {
                      return _buildErrorState();
                    } else if (state is AppointmentActionLoading) {
                      // Show loading indicator when an action is in progress
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Processing...'),
                          ],
                        )
                      );
                    }
                    // Initial state or if no patient is loaded yet
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList(List<AppointmentModel> appointments) {
    final filteredAppointments = _filterAppointments(appointments);

    if (filteredAppointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No appointments found for this category.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: New appointments may take some time to appear as they require approval.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_currentPatientId != null) {
                  context.read<AppointmentCubit>().getPatientAppointments(_currentPatientId!);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF199A8E),
                foregroundColor: Colors.white,
              ),
              child: const Text('Refresh Appointments'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredAppointments.length,
      itemBuilder: (context, index) {
        final appointment = filteredAppointments[index];
        return ScheduleItem(
          appointment: appointment,
          onCancel: () => _cancelAppointment(appointment.id),
          onReschedule: () => _rescheduleAppointment(appointment.id),
        );
      },
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Could not load appointments.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              if (_currentPatientId != null) {
                context
                    .read<AppointmentCubit>()
                    .getPatientAppointments(_currentPatientId!);
              } else {
                _loadCurrentUserAndAppointments();
              }
            },
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }

  List<AppointmentModel> _filterAppointments(
      List<AppointmentModel> appointments) {
    switch (_selectedIndex) {
      case 0: // All
        return appointments;
      case 1: // Upcoming
        return appointments
            .where((app) {
              final status = app.status?.toLowerCase();
              return status == 'pending' || status == 'confirmed';
            })
            .toList();
      case 2: // Completed
        return appointments
            .where((app) => app.status?.toLowerCase() == 'completed')
            .toList();
      case 3: // Canceled
        return appointments
            .where((app) => app.status?.toLowerCase() == 'canceled')
            .toList();
      default:
        return appointments;
    }
  }

  void _cancelAppointment(String appointmentId) {
    // Implement cancel appointment logic
    print('Cancelling appointment: $appointmentId');
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text('Are you sure you want to cancel this appointment?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement API call to cancel appointment
              // Then refresh appointments
              if (_currentPatientId != null) {
                context.read<AppointmentCubit>().getPatientAppointments(_currentPatientId!);
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void _rescheduleAppointment(String appointmentId) {
    // Implement reschedule appointment logic
    print('Rescheduling appointment: $appointmentId');
    // Navigate to reschedule screen
  }

  void _loadUserData() async {
    try {
      final user = await UserService.getCurrentUser();
      
      if (user != null && user.patientId != null) {
        if (mounted) {
          setState(() {
            _currentPatientId = user.patientId;
          });
          
          // Fetch appointments for the current user
          context.read<AppointmentCubit>().getPatientAppointments(_currentPatientId!);
        }
      } else {
        // For development/testing: Create a test user with ID 1
        print('⚠️ No authenticated user found. Using test user with ID 1 for development.');
        if (mounted) {
          setState(() {
            _currentPatientId = 1; // Use a test patient ID
          });
          
          // Fetch appointments for the test user
          context.read<AppointmentCubit>().getPatientAppointments(_currentPatientId!);
        }
      }
    } catch (e) {
      print('❌ Error loading user data: $e');
      // For development/testing: Create a test user with ID 1
      if (mounted) {
        setState(() {
          _currentPatientId = 1;
        });
        
        // Fetch appointments for the test user
        context.read<AppointmentCubit>().getPatientAppointments(_currentPatientId!);
      }
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      final hour = date.hour;
      final minute = date.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return dateString;
    }
  }
}
