import 'package:flutter/material.dart';
import '../../../core/services/saved_blogs_service.dart';
import '../../../models/home_model.dart';
import 'package:better_life/ui/home/HomeMainScreen/ArticleDetailScreen.dart';
import 'package:better_life/ui/home/HomeMainScreen/Widgets/ArticleItem.dart';

class SavedBlogsScreen extends StatefulWidget {
  static const String routeName = 'saved-blogs-screen';

  const SavedBlogsScreen({super.key});

  @override
  State<SavedBlogsScreen> createState() => _SavedBlogsScreenState();
}

class _SavedBlogsScreenState extends State<SavedBlogsScreen> {
  final SavedBlogsService _savedBlogsService = SavedBlogsService();
  List<ArticleModel> _savedArticles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedArticles();
  }

  Future<void> _loadSavedArticles() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final articles = await _savedBlogsService.getSavedArticles();
      setState(() {
        _savedArticles = articles;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading saved articles: $e')),
        );
      }
    }
  }

  Future<void> _removeArticle(String articleId) async {
    try {
      await _savedBlogsService.removeArticle(articleId);
      await _loadSavedArticles(); // Reload the list
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Article removed from saved list')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error removing article: $e')),
        );
      }
    }
  }

  Future<void> _clearAllArticles() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Saved Articles'),
        content: const Text('Are you sure you want to remove all saved articles? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _savedBlogsService.clearAllSavedArticles();
        await _loadSavedArticles(); // Reload the list
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('All saved articles cleared')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error clearing articles: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Saved Articles'),
        backgroundColor: const Color(0xFF199A8E),
        foregroundColor: Colors.white,
        actions: [
          if (_savedArticles.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: _clearAllArticles,
              tooltip: 'Clear All',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _savedArticles.isEmpty
              ? _buildEmptyState()
              : _buildArticlesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No saved articles yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Articles you save will appear here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Browse Articles'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF199A8E),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticlesList() {
    return RefreshIndicator(
      onRefresh: _loadSavedArticles,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _savedArticles.length,
        itemBuilder: (context, index) {
          final article = _savedArticles[index];
          return Dismissible(
            key: Key(article.id),
            direction: DismissDirection.endToStart,
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              color: Colors.red,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              _removeArticle(article.id);
            },
            child: Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticleDetailScreen(article: article),
                    ),
                  );
                  // Refresh the list when returning from article detail
                  if (result == true) {
                    _loadSavedArticles();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Article image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          article.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[300],
                              child: const Icon(Icons.image, color: Colors.grey),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Article details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF199A8E).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    article.category,
                                    style: TextStyle(
                                      color: const Color(0xFF199A8E),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${article.date} • ${article.readTime}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Bookmark icon
                      Icon(
                        Icons.bookmark,
                        color: const Color(0xFF199A8E),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 