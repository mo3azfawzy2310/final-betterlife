import 'package:better_life/ui/home/HomeMainScreen/Widgets/payemntShowDailog.dart';
import 'package:flutter/material.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 10),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: const Color.fromARGB(255, 205, 205, 205)),
          ),
          child: Row(
            children: [
              const Text(
                "Visa",
                style: TextStyle(
                    color: Color(0xff1A1F71),
                    fontSize: 22,
                    fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              MaterialButton(
                  onPressed: () {},
                  child: const Text(
                    "change",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Column(
              children: [
                Text(
                  "Total",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Text(
                  "180 L.E",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () {
              PaymentShowDailog.showAutoCloseDialog(context);    // 
              },
              child: Container(
                alignment: Alignment.center,
                width: 225,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xff199A8E)),
                child: const Text(
                  "Booking",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
