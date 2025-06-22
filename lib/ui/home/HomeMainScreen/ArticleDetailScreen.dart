import 'package:flutter/material.dart';
import '../../../models/home_model.dart';
import '../../../core/services/saved_blogs_service.dart';

class ArticleDetailScreen extends StatefulWidget {
  final ArticleModel article;

  const ArticleDetailScreen({
    super.key,
    required this.article,
  });

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  final SavedBlogsService _savedBlogsService = SavedBlogsService();
  bool _isSaved = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  Future<void> _checkIfSaved() async {
    try {
      final isSaved = await _savedBlogsService.isArticleSaved(widget.article.id);
      setState(() {
        _isSaved = isSaved;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleSaved() async {
    try {
      if (_isSaved) {
        await _savedBlogsService.removeArticle(widget.article.id);
        setState(() {
          _isSaved = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Article removed from saved list')),
          );
        }
      } else {
        await _savedBlogsService.saveArticle(widget.article);
        setState(() {
          _isSaved = true;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Article saved to your list')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
        backgroundColor: const Color(0xFF199A8E),
        foregroundColor: Colors.white,
        actions: [
          if (!_isLoading)
            IconButton(
              icon: Icon(
                _isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: _isSaved ? Colors.yellow : Colors.white,
              ),
              onPressed: _toggleSaved,
              tooltip: _isSaved ? 'Remove from saved' : 'Save article',
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article image
            Container(
              width: double.infinity,
              height: 250,
              child: Image.network(
                widget.article.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image,
                      size: 80,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    widget.article.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Article metadata
                  Row(
                    children: [
                      Icon(
                        Icons.category,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.article.category,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.article.readTime} read',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.article.date,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      if (widget.article.authorName != null) ...[
                        const SizedBox(width: 16),
                        Icon(
                          Icons.person,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.article.authorName!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Article content
                  Text(
                    widget.article.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _toggleSaved,
                      icon: Icon(
                        _isSaved ? Icons.bookmark : Icons.bookmark_border,
                      ),
                      label: Text(
                        _isSaved ? 'Remove from Saved' : 'Save Article',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isSaved ? Colors.red : const Color(0xFF199A8E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 