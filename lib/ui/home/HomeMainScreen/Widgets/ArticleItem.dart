import 'package:flutter/material.dart';

class Articleitem extends StatelessWidget {
  const Articleitem({super.key, required this.articleHistory, required this.ArticleTime, required this.ArtcleImage, required this.ArticleTitle});
  final String articleHistory ;
  final String ArticleTime ;
  final String ArtcleImage;
  final String ArticleTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const  EdgeInsets.symmetric(horizontal: 15,vertical: 10),
      margin: const EdgeInsets.only(right: 25),
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child:  Row(
        children: [
          Image(image: AssetImage(ArtcleImage)),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ArticleTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),),
              const SizedBox(height: 5,),
              Text(articleHistory+ ArticleTime,style: const TextStyle(color: Colors.black,fontSize: 10),
           ) ],
          ),
         const  SizedBox(width: 25,),
          const Icon(Icons.bookmark)
        ],
      )
    );
  }
}