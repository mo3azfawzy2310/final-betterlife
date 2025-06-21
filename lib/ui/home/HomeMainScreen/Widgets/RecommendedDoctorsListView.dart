import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:flutter/material.dart';

class RecommendedDoctorsListView extends StatelessWidget {
  const RecommendedDoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          // Create a sample doctor model
          final doctor = DoctorModel(
            id: 1,
            name: "Dr. Marcus Horizon",
            speciality: "Chardiologist",
            rating: 4.7,
            reviewCount: 124,
            yearsOfExperience: 10,
            patientCount: 1000,
            newVisitPrice: 120,
            email: "marcus@example.com",
            phone: "+1234567890"
          );
          
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DoctorDetailsScreen(doctor: doctor);
                }));
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/homeScreen/Doctor.png'),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      doctor.speciality,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(
                          doctor.rating.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
