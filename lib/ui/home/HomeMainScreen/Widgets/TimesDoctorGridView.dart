import 'package:flutter/material.dart';

class TimesDoctorGridView extends StatefulWidget {
  const TimesDoctorGridView({super.key});

  @override
  State<TimesDoctorGridView> createState() => _TimesDoctorGridViewState();
}

class _TimesDoctorGridViewState extends State<TimesDoctorGridView> {
   final List<String> timeSlots = [   //مواعيد متاحة
    '09:00 AM', '10:00 AM', '11:00 AM',   
    '01:00 PM', '02:00 PM', '03:00 PM',
    '04:00 PM', '07:00 PM', '08:00 PM',
  ];
  final List<String> unavailableSlots = [    //ماعيد غير متاحة
    '09:00 AM', '11:00 AM', '01:00 PM', '08:00 PM',
  ];
  String selectedSlot = '02:00 PM'; // الميعاد المتعلم عليه
  @override
  Widget build(BuildContext context) {
    return   GridView.builder(
      itemCount: timeSlots.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 2.2,
      ),
      itemBuilder: (context, index) {
        final time = timeSlots[index];
        final isSelected = time == selectedSlot;
        final isUnavailable = unavailableSlots.contains(time);

        return GestureDetector(
          onTap: isUnavailable
              ? null
              : () {
                  setState(() {
                    selectedSlot = time;
                  });
                },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isUnavailable
                  ? Colors.grey[200]
                  : isSelected
                      ? const Color(0xFF1AA59A)
                      : Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: isUnavailable
                    ? Colors.grey.shade300
                    : const Color(0xFF1AA59A),
              ),
            ),
            child: Text(
              time,
              style: TextStyle(
                color: isUnavailable
                    ? Colors.grey
                    : isSelected
                        ? Colors.white
                        : Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}