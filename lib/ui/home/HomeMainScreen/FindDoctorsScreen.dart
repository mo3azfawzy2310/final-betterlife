import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/CategoryDoctorItem.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DistanceFromDoctor.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorItem.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorRating.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/FindDoctorSearch_TextField.dart';
import 'package:better_life/ui/logic/doctors/doctors_cubit.dart';
import 'package:better_life/ui/logic/doctors/doctors_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindDoctorsScreen extends StatelessWidget {
  const FindDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF199A8E),
        centerTitle: true,
        title: const Text(
          "Find Doctor",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 0),
            child: FindDoctorSearchTextField(
              onChanged: (query) {
                if (query.isNotEmpty) {
                  context.read<DoctorsCubit>().searchDoctors(query);
                } else {
                  context.read<DoctorsCubit>().getAllDoctors();
                }
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<DoctorsCubit, DoctorsState>(
        builder: (context, state) {
          if (state is DoctorsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DoctorsLoaded) {
            final doctors = state.doctors;
            if (doctors.isEmpty) {
              return const Center(
                child: Text('No doctors found'),
              );
            }
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return _buildDoctorCard(context, doctor);
              },
            );
          } else if (state is DoctorsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DoctorsCubit>().getAllDoctors();
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          
          // Initial state
          return Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<DoctorsCubit>().getAllDoctors();
              },
              child: const Text('Load Doctors'),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildDoctorCard(BuildContext context, DoctorModel doctor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => DoctorDetailsScreen(doctor: doctor),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: doctor.pictureUrl != null
                    ? NetworkImage(doctor.pictureUrl!)
                    : const AssetImage('assets/images/homeScreen/Doctor.png') as ImageProvider,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.speciality,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          doctor.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.location_on, color: Colors.blue, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          doctor.distance != null ? '${doctor.distance!.toStringAsFixed(1)} km' : 'N/A',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
