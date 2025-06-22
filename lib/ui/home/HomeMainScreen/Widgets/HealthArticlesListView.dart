import 'package:better_life/models/home_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/ArticleDetailScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/ArticleItem.dart';
import 'package:flutter/material.dart';

class Healtharticleslistview extends StatelessWidget {
  const Healtharticleslistview({super.key});

  @override
  Widget build(BuildContext context) {
    // Define our health articles with content
    final List<ArticleModel> articles = [
      ArticleModel(
        id: '1',
        title: "The 25 Healthiest Fruits You Can Eat, According to a Nutritionist",
        content: "Fruits are among the most nutritious foods you can eat. They're packed with vitamins, minerals, fiber, and antioxidants, which are beneficial for health and may help prevent various diseases.\n\n"
            "Here are some of the healthiest fruits to include in your diet:\n\n"
            "1. Apples: Rich in fiber and antioxidants, apples may help reduce the risk of chronic diseases.\n\n"
            "2. Blueberries: Packed with antioxidants and phytoflavinoids, blueberries are also high in potassium and vitamin C.\n\n"
            "3. Strawberries: Excellent source of vitamin C and manganese, strawberries can help improve heart health.\n\n"
            "4. Bananas: Great source of potassium, fiber, and several vitamins. They're perfect for active individuals.\n\n"
            "5. Oranges: Known for their vitamin C content, oranges also provide fiber and antioxidants.\n\n"
            "6. Avocados: Actually a fruit, avocados are loaded with healthy fats and fiber.\n\n"
            "7. Pineapple: Contains bromelain, an enzyme that helps reduce inflammation.\n\n"
            "8. Cherries: Rich in antioxidants and anti-inflammatory compounds that may help relieve pain.\n\n"
            "9. Kiwi: Packed with more vitamin C than oranges and a good source of potassium and fiber.\n\n"
            "10. Grapes: Contain resveratrol, which has been linked to heart health benefits.\n\n"
            "Eating a variety of fruits ensures you get a range of nutrients that support overall health. Try to include different colored fruits in your diet for the widest range of benefits.",
        date: "Jun 10, 2023",
        category: "Nutrition",
        readTime: "5min read",
        imageUrl: "assets/images/homeScreen/Rectangle 460.png",
        authorName: "Dr. Sarah Johnson",
      ),
      ArticleModel(
        id: '2',
        title: "10 Simple Ways to Boost Your Mental Health Daily",
        content: "Taking care of your mental health is just as important as maintaining your physical health. Small daily habits can make a significant difference in your overall wellbeing.\n\n"
            "Here are 10 simple ways to boost your mental health every day:\n\n"
            "1. Practice mindfulness and meditation for just 5-10 minutes each day.\n\n"
            "2. Get regular physical exercise, even if it's just a short walk.\n\n"
            "3. Maintain a consistent sleep schedule and aim for 7-8 hours of quality sleep.\n\n"
            "4. Connect with friends and family regularly, even if just through a quick phone call.\n\n"
            "5. Limit screen time and take breaks from social media.\n\n"
            "6. Spend time outdoors in nature whenever possible.\n\n"
            "7. Practice gratitude by noting three things you're thankful for each day.\n\n"
            "8. Engage in activities that bring you joy and relaxation.\n\n"
            "9. Maintain a balanced diet with foods that support brain health.\n\n"
            "10. Set boundaries and learn to say no when needed.\n\n"
            "Remember that mental health is a journey, not a destination. Be patient with yourself and recognize that it's okay to seek professional help when needed. Small, consistent actions can lead to significant improvements in your mental wellbeing over time.",
        date: "Mar 3, 2023",
        category: "Mental Health",
        readTime: "4min read",
        imageUrl: "assets/images/homeScreen/Rectangle 460.png",
        authorName: "Dr. Michael Chen",
      ),
      ArticleModel(
        id: '3',
        title: "Healthy Eating Habits That Can Change Your Life",
        content: "Developing healthy eating habits can transform your physical health, mental wellbeing, and overall quality of life. The key is to make sustainable changes rather than following strict diets.\n\n"
            "Here are some healthy eating habits that can make a significant difference:\n\n"
            "1. Eat mindfully: Pay attention to what you're eating, chew slowly, and savor each bite without distractions like TV or smartphones.\n\n"
            "2. Include protein with every meal: Protein helps you feel fuller longer and supports muscle maintenance.\n\n"
            "3. Fill half your plate with vegetables: They provide essential nutrients and fiber while being low in calories.\n\n"
            "4. Stay hydrated: Often we mistake thirst for hunger. Drink water throughout the day.\n\n"
            "5. Plan your meals: Preparing meals in advance can prevent impulsive, unhealthy food choices.\n\n"
            "6. Read food labels: Become aware of hidden sugars, sodium, and unhealthy fats in processed foods.\n\n"
            "7. Practice portion control: Use smaller plates and be mindful of serving sizes.\n\n"
            "8. Limit processed foods: Focus on whole, unprocessed foods as much as possible.\n\n"
            "9. Include healthy fats: Incorporate sources like avocados, nuts, and olive oil.\n\n"
            "10. Listen to your body's hunger and fullness cues: Eat when you're hungry and stop when you're satisfied, not overly full.\n\n"
            "Remember that consistency matters more than perfection. Small, sustainable changes to your eating habits can lead to significant health improvements over time.",
        date: "Feb 20, 2023",
        category: "Nutrition",
        readTime: "6min read",
        imageUrl: "assets/images/homeScreen/Rectangle 460.png",
        authorName: "Dr. Emily Parker",
      ),
      ArticleModel(
        id: '4',
        title: "How Walking 30 Minutes a Day Can Improve Your Health",
        content: "Walking is one of the simplest yet most effective forms of exercise. Just 30 minutes of walking each day can provide numerous health benefits without requiring expensive equipment or gym memberships.\n\n"
            "Here's how a daily 30-minute walk can improve your health:\n\n"
            "1. Heart health: Regular walking can lower your risk of heart disease and stroke by improving circulation and reducing blood pressure.\n\n"
            "2. Weight management: Walking burns calories and can help maintain a healthy weight, especially when combined with healthy eating habits.\n\n"
            "3. Mental wellbeing: Walking, particularly in nature, can reduce stress, anxiety, and symptoms of depression while improving mood.\n\n"
            "4. Better sleep: Regular physical activity like walking can help you fall asleep faster and enjoy deeper sleep.\n\n"
            "5. Stronger bones and muscles: Walking is a weight-bearing exercise that helps strengthen bones and muscles, reducing the risk of osteoporosis.\n\n"
            "6. Improved balance and coordination: Regular walking helps maintain mobility and can reduce the risk of falls, especially in older adults.\n\n"
            "7. Enhanced immune function: Moderate exercise such as walking can boost your immune system, potentially reducing the frequency of illnesses.\n\n"
            "8. Blood sugar control: Walking after meals can help lower blood sugar levels, which is particularly beneficial for people with diabetes.\n\n"
            "9. Joint health: Walking lubricates knee and hip joints, strengthening the muscles that support them.\n\n"
            "10. Longer lifespan: Studies have shown that regular walkers tend to live longer and healthier lives.\n\n"
            "To get started, simply incorporate walking into your daily routine. You can break it up into shorter sessions throughout the day if needed. The key is consistency—making walking a regular habit will yield the greatest benefits for your health.",
        date: "Jan 5, 2023",
        category: "Fitness",
        readTime: "3min read",
        imageUrl: "assets/images/homeScreen/Rectangle 460.png",
        authorName: "Dr. Robert Williams",
      ),
      ArticleModel(
        id: '5',
        title: "Why Drinking More Water Can Save Your Life",
        content: "Water is essential for life, yet many people don't drink enough of it. Proper hydration affects almost every aspect of your health and can quite literally be lifesaving.\n\n"
            "Here's why drinking adequate water is crucial for your health:\n\n"
            "1. Cell function: Water is essential for cells to work properly. It transports nutrients to cells and removes waste products.\n\n"
            "2. Brain performance: Even mild dehydration can impair cognitive function, mood, concentration, and memory.\n\n"
            "3. Energy levels: Water helps convert food into energy. Dehydration often causes fatigue.\n\n"
            "4. Heart health: Proper hydration makes it easier for the heart to pump blood through the blood vessels to the muscles.\n\n"
            "5. Temperature regulation: Water helps maintain body temperature through sweating and respiration.\n\n"
            "6. Digestive health: Water aids digestion and prevents constipation.\n\n"
            "7. Kidney function: Water helps the kidneys filter waste products and helps prevent kidney stones.\n\n"
            "8. Joint lubrication: Water keeps the cartilage around joints hydrated and elastic.\n\n"
            "9. Skin health: Proper hydration helps keep skin elastic, moisturized, and less prone to wrinkling.\n\n"
            "10. Detoxification: Water flushes toxins from your body, primarily through urination.\n\n"
            "How much water should you drink? While needs vary based on factors like activity level, climate, and overall health, a general guideline is to aim for about 8 glasses (64 ounces) daily. A good indicator of hydration is the color of your urine—pale yellow typically indicates proper hydration.\n\n"
            "Simple ways to increase your water intake include carrying a reusable water bottle, setting reminders to drink water throughout the day, and eating water-rich foods like cucumbers, watermelon, and oranges.",
        date: "Dec 15, 2022",
        category: "Wellness",
        readTime: "2min read",
        imageUrl: "assets/images/homeScreen/Rectangle 460.png",
        authorName: "Dr. Amanda Lee",
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArticleDetailScreen(article: article),
                  ),
                );
              },
              child: Articleitem(
                ArticleTitle: article.title,
                ArticleTime: article.readTime,
                articleHistory: article.date,
                ArtcleImage: article.imageUrl,
              ),
            ),
          );
        },
      ),
    );
  }
}
