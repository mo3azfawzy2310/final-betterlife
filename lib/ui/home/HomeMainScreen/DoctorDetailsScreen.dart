import 'package:better_life/ui/home/HomeMainScreen/AppointmentScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/DoctorDetailedItem.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TimesDoctorGridView.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/WeekDaysListView.dart';
import 'package:flutter/material.dart';

class Doctordetailsscreen extends StatelessWidget {
  const Doctordetailsscreen({super.key});

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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(children: [
            DoctorDetailedItem(
              DoctorImage:
                  "assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png",
              DoctorName: "Dr ALi Ebrahim",
              DoctorSpecality: "chardiologist",
              DoctorRating: "4.7",
              distance: "800",
            ),
            const SizedBox(height: 20,),
            const Weekdayslistview(),
            const SizedBox(
              height: 50,
            ),
            const TimesDoctorGridView(),
            const SizedBox(
              height: 75,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:const  Color(0xffE8F3F1)),
                    child: const Image(
                        image: AssetImage(
                            "assets/images/homeScreen/Stroke 4.png")),
                  ),
                ),
               const  SizedBox(
                  width: 20,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const Appointmentscreen();
                    }));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 265,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:const  Color(0xff199A8E)
                    ),
                    child: const Text("Book Appointment",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                  
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
