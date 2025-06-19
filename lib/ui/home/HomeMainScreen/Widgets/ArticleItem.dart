import 'package:flutter/material.dart';

class Articleitem extends StatelessWidget {
  const Articleitem(
      {super.key,
      required this.articleHistory,
      required this.ArticleTime,
      required this.ArtcleImage,
      required this.ArticleTitle});
  final String articleHistory;
  final String ArticleTime;
  final String ArtcleImage;
  final String ArticleTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(right: 25),
        // Remove fixed height to allow content to determine height
        constraints: const BoxConstraints(minHeight: 75),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Fixed size for the image to maintain consistency
            SizedBox(
              width: 50,
              height: 50,
              child: Image(
                image: AssetImage(ArtcleImage),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            // Expanded widget to allow text to take available space and wrap if needed
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ArticleTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    // Make text wrap to prevent overflow
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$articleHistory • $ArticleTime",
                    style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.bookmark)
          ],
        ));
  }
}
