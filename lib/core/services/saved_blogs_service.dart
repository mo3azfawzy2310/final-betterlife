import 'dart:convert';
import '../cach_data/app_shared_preferences.dart';
import '../../models/home_model.dart';

class SavedBlogsService {
  static const String _savedBlogsKey = 'saved_blogs';
  static final SavedBlogsService _instance = SavedBlogsService._internal();
  
  factory SavedBlogsService() {
    return _instance;
  }
  
  SavedBlogsService._internal();

  /// Save an article to saved blogs
  Future<void> saveArticle(ArticleModel article) async {
    try {
      final savedArticles = await getSavedArticles();
      
      // Check if article already exists
      if (!savedArticles.any((saved) => saved.id == article.id)) {
        savedArticles.add(article);
        
        // Convert to JSON and save
        final articlesJson = savedArticles.map((article) => article.toJson()).toList();
        await AppPreferences().setData(_savedBlogsKey, jsonEncode(articlesJson));
      }
    } catch (e) {
      print('Error saving article: $e');
      rethrow;
    }
  }

  /// Remove an article from saved blogs
  Future<void> removeArticle(String articleId) async {
    try {
      final savedArticles = await getSavedArticles();
      savedArticles.removeWhere((article) => article.id == articleId);
      
      // Convert to JSON and save
      final articlesJson = savedArticles.map((article) => article.toJson()).toList();
      await AppPreferences().setData(_savedBlogsKey, jsonEncode(articlesJson));
    } catch (e) {
      print('Error removing article: $e');
      rethrow;
    }
  }

  /// Get all saved articles
  Future<List<ArticleModel>> getSavedArticles() async {
    try {
      final articlesJson = await AppPreferences().getData(_savedBlogsKey);
      
      if (articlesJson == null || articlesJson.toString().isEmpty) {
        return [];
      }
      
      final List<dynamic> articlesList = jsonDecode(articlesJson);
      return articlesList.map((json) => ArticleModel.fromJson(json)).toList();
    } catch (e) {
      print('Error getting saved articles: $e');
      return [];
    }
  }

  /// Check if an article is saved
  Future<bool> isArticleSaved(String articleId) async {
    try {
      final savedArticles = await getSavedArticles();
      return savedArticles.any((article) => article.id == articleId);
    } catch (e) {
      print('Error checking if article is saved: $e');
      return false;
    }
  }

  /// Clear all saved articles
  Future<void> clearAllSavedArticles() async {
    try {
      await AppPreferences().removeData(_savedBlogsKey);
    } catch (e) {
      print('Error clearing saved articles: $e');
      rethrow;
    }
  }

  /// Get saved articles count
  Future<int> getSavedArticlesCount() async {
    try {
      final savedArticles = await getSavedArticles();
      return savedArticles.length;
    } catch (e) {
      print('Error getting saved articles count: $e');
      return 0;
    }
  }
} 