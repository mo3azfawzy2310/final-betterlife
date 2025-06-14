import 'package:better_life/ui/home/HomeMainScreen/Widgets/ArticleItem.dart';
import 'package:flutter/material.dart';

class Healtharticleslistview extends StatelessWidget {
  const Healtharticleslistview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Articleitem(
            ArticleTitle:
                "The 25 Healthiest Fruits You Can Eat,\n According to a Nutritionist",
            ArticleTime: "5min read",
            articleHistory: "Jun 10, 2021 ",
            ArtcleImage: "assets/images/homeScreen/Rectangle 460.png",
          ),
        );
      },
    );
  }
}
