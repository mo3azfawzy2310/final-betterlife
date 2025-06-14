import 'package:better_life/ui/home/HomeMainScreen/Widgets/HealthArticlesListView.dart';
import 'package:flutter/material.dart';

class HealthArticles_Section extends StatelessWidget {
  const HealthArticles_Section({super.key, required this.SeeAll_onPressed});
  final VoidCallback SeeAll_onPressed;
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
