import 'package:flutter/material.dart';

class DateAppointmentSection extends StatelessWidget {
  const DateAppointmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const Text(
            "Date",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
          ),
          const Spacer(),
          MaterialButton(
              onPressed: () {},
              child: const Text(
                "change",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              )),
        ]),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.calendar_month_outlined)),
            const SizedBox(
              width: 30,
            ),
            const Text(
              "Wednesday, Jun 23, 2021 | 10:00 AM",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const SizedBox(
            width: 300,
            child: Divider(
              color: Color.fromARGB(255, 201, 199, 199),
              thickness: 1,
            ))
      ],
    );
  }
}
