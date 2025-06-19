import 'package:better_life/core/network/api_consumer.dart';
import 'package:better_life/models/home_model.dart';
import 'package:better_life/ui/logic/auth/dio_factory.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'homecubit_state.dart';

class HomecubitCubit extends Cubit<HomecubitState> {
  HomecubitCubit() : super(HomecubitInitial());
  final ApiConsumer api = DioFactory.getDioConsumer();

  List<DoctorModel> doctors = [];
  List<HealthArticleModel> articles = [];

  Future<void> getAllDoctorsAndArticles() async {
    emit(HomecubitLoding());
    try {
      final doctorsResponse = await api.get("Patient/Doctors");
      final articlesResponse =
          await api.get("MedicalRecords", queryParameters: {"patientId": 4});

      doctors = List<DoctorModel>.from(
        (doctorsResponse as List).map((e) => DoctorModel.fromJson(e)),
      );

      // articles = List<HealthArticleModel>.from(
      //   (articlesResponse as List).map((e) => HealthArticleModel.fromJson(e)),
      // );

      emit(HomecubitSuccess());
    } catch (e) {
      emit(HomecubitFailure(e.toString()));
    }
  }
}
