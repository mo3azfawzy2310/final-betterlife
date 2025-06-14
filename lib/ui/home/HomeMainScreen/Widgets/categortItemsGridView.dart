import 'package:better_life/ui/home/HomeMainScreen/Widgets/Categoriesdoctorlist.dart';
import 'package:flutter/material.dart';

class categortItemsGridView extends StatelessWidget {
  const categortItemsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4),
        itemCount: Categoriesdoctorlist.categoriesdoctorlist.length,
        itemBuilder: (context, index) {
          return Categoriesdoctorlist.categoriesdoctorlist[index];    //list of categories
        },
        ),
    );
  }
}