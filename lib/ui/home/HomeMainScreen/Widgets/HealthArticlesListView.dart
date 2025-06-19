import 'package:better_life/ui/home/HomeMainScreen/Widgets/ArticleItem.dart';
import 'package:flutter/material.dart';

class Healtharticleslistview extends StatelessWidget {
  const Healtharticleslistview({super.key});

  @override
  Widget build(BuildContext context) {
    // 🟩 بيانات ثابتة للمقالات
    final List<Map<String, String>> articles = [
      {
        "title":
            "The 25 Healthiest Fruits You Can Eat, According to a Nutritionist",
        "time": "5min read",
        "date": "Jun 10, 2021",
        "image": "assets/images/homeScreen/Rectangle 460.png",
      },
      {
        "title": "10 Simple Ways to Boost Your Mental Health Daily",
        "time": "4min read",
        "date": "Mar 3, 2022",
        "image": "assets/images/homeScreen/Rectangle 461.png",
      },
      {
        "title": "Healthy Eating Habits That Can Change Your Life",
        "time": "6min read",
        "date": "Feb 20, 2023",
        "image": "assets/images/homeScreen/Rectangle 462.png",
      },
      {
        "title": "How Walking 30 Minutes a Day Can Improve Your Health",
        "time": "3min read",
        "date": "Jan 5, 2023",
        "image": "assets/images/homeScreen/Rectangle 463.png",
      },
      {
        "title": "Why Drinking More Water Can Save Your Life",
        "time": "2min read",
        "date": "Dec 15, 2022",
        "image": "assets/images/homeScreen/Rectangle 464.png",
      },
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Articleitem(
            ArticleTitle: article["title"]!,
            ArticleTime: article["time"]!,
            articleHistory: article["date"]!,
            ArtcleImage: article["image"]!,
          ),
        );
      },
    );
  }
}
