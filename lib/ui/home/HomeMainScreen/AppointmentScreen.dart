import 'package:better_life/ui/home/HomeMainScreen/Widgets/DateAppointmentSection.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorDetailedItem.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/PaymentDetailsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/PaymentMethodSection.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/ReasonAppointmentSection.dart';
import 'package:flutter/material.dart';

class Appointmentscreen extends StatelessWidget {
  const Appointmentscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Appointments",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            DoctorDetailedItem(
              DoctorImage:
                  "assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png",
              DoctorName: "Dr ALi Ebrahim",
              DoctorSpecality: "chardiologist",
              DoctorRating: "4.7",
             
            ),
            const SizedBox(
              height: 5,
            ),
            const DateAppointmentSection(),
            const SizedBox(
              height: 5,
            ),
            const ReasonAppointmentSection(),
            const SizedBox(
              height: 5,
            ),
            const PaymentDetailsScreen(),
            const SizedBox(
              height: 5,
            ),
            const PaymentMethodSection(),
          ],
        ),
      ),
    );
  }
}
