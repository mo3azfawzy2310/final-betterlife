import 'package:better_life/ui/home/HomeMainScreen/Widgets/CategoryDoctorItem.dart';

class Categoriesdoctorlist 
{
  static List<CategoryDoctorItem> categoriesdoctorlist = [
     CategoryDoctorItem(categoryName: "General", categoryImage: "assets/images/homeScreen/Doctor.png",category_OnPressed: (){} ),
     CategoryDoctorItem(categoryName: "Lungs Specialist", categoryImage: "assets/images/homeScreen/Lungs.png",category_OnPressed: (){} ),
     CategoryDoctorItem(categoryName: "Dentist", categoryImage: "assets/images/homeScreen/Dentist.png",category_OnPressed: (){} ),
     CategoryDoctorItem(categoryName: "Psychiatrist", categoryImage: "assets/images/homeScreen/Psychiatrist.png",category_OnPressed: (){}),
     CategoryDoctorItem(categoryName: "Covid-19", categoryImage: "assets/images/homeScreen/Group.png",category_OnPressed: (){}),
     CategoryDoctorItem(categoryName: "Surgeon", categoryImage: "assets/images/homeScreen/Vector.png",category_OnPressed: (){}),
     CategoryDoctorItem(categoryName: "Cardiologist", categoryImage: "assets/images/homeScreen/Cardiologist.png",category_OnPressed: (){}),


  ];
}