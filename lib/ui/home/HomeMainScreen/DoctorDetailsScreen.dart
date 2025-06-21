import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/BookAppointmentScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorDetailedItem.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TimesDoctorGridView.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/WeekDaysListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_life/ui/logic/appointment/appointment_cubit.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final DoctorModel doctor;
  static const String routeName = 'doctor-details-screen';

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 27,
                color: Colors.black,
              )),
          title: const Text(
            "Doctor",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorProfile(),
              const SizedBox(height: 20),
              _buildDoctorInfo(),
              const SizedBox(height: 20),
              _buildBookAppointmentButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorProfile() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: doctor.pictureUrl != null
                  ? NetworkImage(doctor.pictureUrl!)
                  : const AssetImage('assets/images/homeScreen/Doctor.png')
                      as ImageProvider,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor.speciality,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(Icons.comment, color: Colors.blue, size: 20),
                      const SizedBox(width: 4),
                      Text('${doctor.reviewCount} Reviews'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfo() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Experience', '${doctor.yearsOfExperience} years'),
            const Divider(),
            _buildInfoRow('Patients', '${doctor.patientCount}+ Patients'),
            const Divider(),
            _buildInfoRow('New Visit Price', '\$${doctor.newVisitPrice}'),
            const Divider(),
            _buildInfoRow('Speciality', doctor.speciality),
            const Divider(),
            const Text(
              'About Doctor',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              doctor.about ?? 'No information available about this doctor.',
              style: TextStyle(
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookAppointmentButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => AppointmentCubit(),
                child: BookAppointmentScreen(
                  doctor: doctor,
                  onBookingComplete: () {
                    // Pop back to this screen first
                    Navigator.of(context).pop();
                    
                    // Then show a snackbar with instructions
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Appointment booked! Check your schedule.'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF199A8E),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Book Appointment',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
