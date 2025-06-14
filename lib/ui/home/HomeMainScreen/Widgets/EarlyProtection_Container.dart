import 'package:better_life/ui/home/HomeMainScreen/Widgets/LearnMore_Botton.dart';
import 'package:flutter/material.dart';

class EarlyProtection_Container extends StatelessWidget {
  const EarlyProtection_Container({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 400,
      height: 150,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(
        right: 25,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffE8F3F1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Early protection for \nyour family health",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              LearnmoreBotton(
                LearmMore_OnPressed: () {},
              )
            ],
          ),
          const Spacer(),
          Container(
            // Wite Container around image
            width: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/homeScreen/pexels-cedric-fauntleroy-4270371@2x.png",
                    ),
                  ),
                  color: Colors.white,
                  shape: BoxShape.circle),
            ),
          )
        ],
      ),
    );
  }
}
