import 'package:flutter/material.dart';

class CategoryDoctorItem extends StatelessWidget {
  const CategoryDoctorItem(
      {super.key, required this.categoryName, required this.categoryImage, required this.category_OnPressed});
  final String categoryName;
  final String categoryImage;
  final VoidCallback category_OnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: category_OnPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
              categoryImage,
            ),
            height: 60,
          ),
          const SizedBox(
            height: 5,
          ),
          FittedBox(
            child: Text(
              categoryName,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xffA1A8B0)),
            ),
          ),
        ],
      ),
    );
  }
}
