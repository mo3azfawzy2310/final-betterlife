import 'package:better_life/models/home_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/HealthArticlesListView.dart';
import 'package:flutter/material.dart';

class HealthArticles_Section extends StatelessWidget {
  const HealthArticles_Section({
    Key? key,
    required this.SeeAll_onPressed,
    required this.articles,
  }) : super(key: key);
  
  final VoidCallback SeeAll_onPressed;
  final List<HealthArticleModel> articles;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Health Articles",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                    onPressed: SeeAll_onPressed, child: const Text("See All"))),
          ],
        ),
        const Healtharticleslistview()
      ],
    );
  }
}
