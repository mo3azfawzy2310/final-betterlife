import 'package:better_life/ui/home/HomeMainScreen/Widgets/cancel&Reschdule_botton.dart';
import 'package:flutter/material.dart';

class sheduleItem extends StatelessWidget {
  const sheduleItem({super.key, required this.DoctorName, required this.Spaclist, required this.DoctorImage, required this.Date, required this.time, });
  final String DoctorName ;
  final String Spaclist ;
  final String DoctorImage;
  final String Date ;
  final String time ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 220, 220, 220)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DoctorName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                      Text(
                        Spaclist,
                        style: const TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        DoctorImage),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.grey,
                        size: 20,
                      )),
                      Text(Date,style: const TextStyle(color: Color.fromARGB(255, 109, 109, 109),fontSize: 12,fontWeight: FontWeight.bold),)
                      ,const SizedBox(width: 10,),
                      const Icon(Icons.watch_later_outlined,color: Colors.grey,size: 20,),
                      Text(time,style: const TextStyle(color: Color.fromARGB(255, 109, 109, 109),fontSize: 12,fontWeight: FontWeight.bold),),
                      const SizedBox(width: 10,),
                      Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle
                      )),
                      const Text("Confirmed",style: TextStyle(color: Color.fromARGB(255, 109, 109, 109),fontSize: 12,fontWeight: FontWeight.bold),),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Cancel_reschduleBotton(onpressed: (){}, text: "Cancel", containercolor: const Color.fromARGB(255, 226, 226, 226), textcolor: Colors.black)),
                  const SizedBox(width: 10,),
                  Expanded(child: Cancel_reschduleBotton(onpressed: (){}, text: "Reschedule", containercolor: const Color(0xff199A8E), textcolor:Colors.white,))
                ],

              )
            ],
          ),
        ));
  }
}
