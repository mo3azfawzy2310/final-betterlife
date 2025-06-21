import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/models/doctor_model.dart';
import 'package:better_life/models/home_model.dart' as home_model;
import 'package:better_life/ui/logic/auth/dio_factory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homecubit_state.dart';

class HomecubitCubit extends Cubit<HomecubitState> {
  HomecubitCubit() : super(HomecubitInitial());
  final ApiConsumer api = DioFactory.getDioConsumer();

  List<DoctorModel> doctors = [];
  List<home_model.HealthArticleModel> articles = [];

  Future<void> getAllDoctorsAndArticles() async {
    emit(HomecubitLoding());
    try {
      // Use mock data instead of API calls for now
      mockDoctors();
      
      // Mock articles
      articles = [
        home_model.HealthArticleModel(
          id: "1",
          date: "2023-07-15",
          diagnoses: "Hypertension",
          prescription: "Amlodipine 5mg daily",
          speciality: "Cardiology",
          doctorName: "Dr. Marcus Horizon",
          patientName: "John Doe",
          lapTests: [],
          radiation: [],
        ),
        home_model.HealthArticleModel(
          id: "2",
          date: "2023-08-22",
          diagnoses: "Migraine",
          prescription: "Sumatriptan as needed",
          speciality: "Neurology",
          doctorName: "Dr. Sarah Johnson",
          patientName: "Jane Smith",
          lapTests: [],
          radiation: [],
        ),
      ];

      emit(HomecubitSuccess());
    } catch (e) {
      emit(HomecubitFailure(e.toString()));
    }
  }

  // Mock doctors
  void mockDoctors() {
    doctors = [
      DoctorModel(
        id: 1,
        name: "Dr. Marcus Horizon",
        speciality: "Cardiologist",
        rating: 4.7,
        reviewCount: 124,
        yearsOfExperience: 10,
        patientCount: 1000,
        newVisitPrice: 120,
        email: "marcus@example.com",
        phone: "+1234567890"
      ),
      DoctorModel(
        id: 2,
        name: "Dr. Sarah Johnson",
        speciality: "Neurologist",
        rating: 4.5,
        reviewCount: 98,
        yearsOfExperience: 8,
        patientCount: 800,
        newVisitPrice: 150,
        email: "sarah@example.com",
        phone: "+1987654321"
      ),
      DoctorModel(
        id: 3,
        name: "Dr. Michael Chen",
        speciality: "Dermatologist",
        rating: 4.9,
        reviewCount: 156,
        yearsOfExperience: 12,
        patientCount: 1200,
        newVisitPrice: 135,
        email: "michael@example.com",
        phone: "+1122334455"
      ),
    ];
  }
}
