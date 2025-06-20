import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:better_life/ui/home/HomeMainScreen/TopDoctorsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/EarlyProtection_Container.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/HealthArticles_Section.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopDectors_Section.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopSection.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/Search_Container.dart';

import 'package:better_life/ui/logic/home/homecubit_cubit.dart';

class Homemainscreen extends StatelessWidget {
  const Homemainscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            // Refresh the data when the user pulls down to refresh
            context.read<HomecubitCubit>().getAllDoctorsAndArticles();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: BlocBuilder<HomecubitCubit, HomecubitState>(
              builder: (context, state) {
                if (state is HomecubitLoding) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomecubitFailure) {
                  return Center(child: Text("Error: ${state.message}"));
                } else if (state is HomecubitSuccess) {
                  final cubit = context.read<HomecubitCubit>();
                  final doctors = cubit.doctors;
                  final articles = cubit.articles;
    
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Topsection(
                          Notifications_Onpressed: () {},
                          text: 'Find your desire\nhealth solution',
                        ),
                        const SizedBox(height: 25),
                        const Search_Container(),
                        const SizedBox(height: 30),
                        const EarlyProtection_Container(),
                        const SizedBox(height: 15),
                        TopDectors_Section(
                          doctors: doctors,
                          SeeALl_onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const Topdoctorsscreen();
                              },
                            ));
                          },
                        ),
                        const SizedBox(height: 15),
                        HealthArticles_Section(
                          articles: articles,
                          SeeAll_onPressed: () {},
                        ),
                      ],
                    ),
                  );
                } else {
                  // Default case (initial state)
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
