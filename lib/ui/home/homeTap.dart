import 'package:better_life/ui/home/HomeMainScreen/HomeMainScreen.dart';
import 'package:better_life/ui/logic/home/homecubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize the home cubit to load doctors and articles
    context.read<HomecubitCubit>().getAllDoctorsAndArticles();
    
    return const Homemainscreen();
  }
}
