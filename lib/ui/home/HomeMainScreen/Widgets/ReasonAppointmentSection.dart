import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReasonAppointmentSection extends StatelessWidget {
  const ReasonAppointmentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          const Text(
            "Reason",
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
                icon: const Icon(FontAwesomeIcons.edit)),
            const SizedBox(
              width: 30,
            ),
            const Text(
              "Chest Pain",
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
