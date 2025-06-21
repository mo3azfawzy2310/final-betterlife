import 'package:better_life/ui/home/HomeMainScreen/FindDoctorsScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Search_Container extends StatelessWidget {
  const Search_Container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const FindDoctorsScreen();
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        width: 340,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffFBFBFB),
          border: Border.all(color: const Color.fromARGB(255, 214, 213, 213)),
        ),
        child: const Row(
          children: [
            Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: Color(0xffADADAD),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Search doctor, drugs, articles...",
              style: TextStyle(color: Color(0xffADADAD)),
            )
          ],
        ),
      ),
    );
  }
}
