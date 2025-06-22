import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:better_life/ui/home/HomeMainScreen/TopDoctorsScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/EarlyProtection_Container.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/HealthArticles_Section.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopDectors_Section.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/TopSection.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/Search_Container.dart';

import 'package:better_life/ui/logic/appointment/appointment_cubit.dart';
import 'package:better_life/ui/logic/doctors/doctors_cubit.dart';
import 'package:better_life/ui/home/HomeMainScreen/DoctorDetailsScreen.dart';
import 'package:better_life/ui/logic/home/homecubit_cubit.dart';

class Homemainscreen extends StatelessWidget {
  const Homemainscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => DoctorsCubit()..getAllDoctors()),
        ],
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Topsection(
                            Notifications_Onpressed: () {
                              // Show notifications
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Notifications feature coming soon!'),
                                ),
                              );
                            },
                            text: 'Find your desire\nhealth solution',
                          ),
                          const SizedBox(height: 15),
                          const Search_Container(),
                          const SizedBox(height: 15),
                          const EarlyProtection_Container(),
                          const SizedBox(height: 15),
                          TopDectors_Section(
                            SeeALl_onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Topdoctorsscreen(),
                                ),
                              );
                            },
                            doctors: doctors,
                            onDoctorSelected: (doctor) async {
                              final result = await Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider(
                                    create: (context) => AppointmentCubit(),
                                    child: DoctorDetailsScreen(doctor: doctor),
                                  ),
                                ),
                              );
                              
                              // If booking was successful, navigate to the schedule tab
                              if (result == true) {
                                // Find the parent HomeScreen to switch tabs
                                Navigator.of(context).pop(); // Go back to home screen
                                
                                // Use delayed execution to ensure we're back on the home screen
                                Future.delayed(Duration.zero, () {
                                  // Show a message to the user that the booking was successful
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Appointment booked successfully! Navigate to Schedule tab to see your booking.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                });
                              }
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
                  }
                  
                  return const Center(
                    child: Text("No data available"),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
