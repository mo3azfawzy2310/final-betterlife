import 'package:flutter/material.dart';

class Weekdayslistview extends StatefulWidget {
  const Weekdayslistview({super.key});

  @override
  State<Weekdayslistview> createState() => _WeekdayslistviewState();
}

class _WeekdayslistviewState extends State<Weekdayslistview> {
   int selectedIndex = 2; // مبدئيًا اليوم المختار هو الاربعاء

  final List<Map<String, String>> days = [
    {'day': 'Mon', 'date': '21'},
    {'day': 'Tue', 'date': '22'},
    {'day': 'Wed', 'date': '23'},
    {'day': 'Thu', 'date': '24'},
    {'day': 'Fri', 'date': '25'},
    {'day': 'Sat', 'date': '26'},
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 17),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1AA59A) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE1E8ED),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days[index]['day']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    days[index]['date']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ));
  }
}