import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final String authorId;
  final String authorName;
  final String? authorPhotoUrl;
  final List<String> tags;
  final String category;
  final DateTime publishedAt;
  final DateTime createdAt;
  final int views;
  final int likes;
  final bool isPublished;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    required this.authorId,
    required this.authorName,
    this.authorPhotoUrl,
    this.tags = const [],
    required this.category,
    required this.publishedAt,
    required this.createdAt,
    this.views = 0,
    this.likes = 0,
    this.isPublished = true,
  });

  factory BlogModel.fromMap(Map<String, dynamic> map, String id) {
    return BlogModel(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['imageUrl'],
      videoUrl: map['videoUrl'],
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? '',
      authorPhotoUrl: map['authorPhotoUrl'],
      tags: List<String>.from(map['tags'] ?? []),
      category: map['category'] ?? '',
      publishedAt: (map['publishedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      views: map['views'] ?? 0,
      likes: map['likes'] ?? 0,
      isPublished: map['isPublished'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'authorId': authorId,
      'authorName': authorName,
      'authorPhotoUrl': authorPhotoUrl,
      'tags': tags,
      'category': category,
      'publishedAt': Timestamp.fromDate(publishedAt),
      'createdAt': Timestamp.fromDate(createdAt),
      'views': views,
      'likes': likes,
      'isPublished': isPublished,
    };
  }
}

