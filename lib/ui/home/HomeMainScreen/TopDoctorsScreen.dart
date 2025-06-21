import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:flutter/material.dart';

class Topdoctorsscreen extends StatelessWidget {
  const Topdoctorsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Add a sample doctor model for the DoctorDetailsScreen
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Top Doctors"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/homeScreen/Doctor.png"),
                ),
                title: const Text("Dr. Marcus Horizon"),
                subtitle: const Text("Cardiologist"),
                trailing: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) {
                        return DoctorDetailsScreen(doctor: doctor);
                      })
                    ).then((goToSchedule) {
                      // If returned value is true, it means we should navigate to schedule screen
                      if (goToSchedule == true) {
                        // Pop back to home screen with a signal to go to schedule tab
                        Navigator.pop(context, true);
                      }
                    });
                  },
                  child: const Text("View"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
