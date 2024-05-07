import 'package:aura/domain/model/comment_model.dart';
import 'package:aura/domain/model/user_model.dart';

class SavedPosts {
  final String id;
  final User user;
  final List posts;
  final String createdAt;
  final String updatedAt;

  SavedPosts({
    required this.id,
    required this.user,
    required this.posts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavedPosts.fromJson(Map<String, dynamic> json) {
    return SavedPosts(
      id: json['_id'],
      user: User.fromJson(json['userId']),
      posts: (json['posts'] as List<dynamic>)
          .map((postData) => PostModelSavePost.fromJson(postData))
          .toList(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class PostModelSavePost {
  final String id;
  final User user;
  final String description;
  final List<String> mediaURL;
  final List<String> likes;
  final List<CommentModel> comments;
  final String location;
  final bool isBlocked;
  final String createdAt;
  final String updatedAt;

  PostModelSavePost({
    required this.id,
    required this.user,
    required this.description,
    required this.mediaURL,
    required this.likes,
    required this.comments,
    required this.location,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModelSavePost.fromJson(Map<String, dynamic> json) {
    return PostModelSavePost(
      id: json['_id'],
      user: User.fromJson(json['userId']),
      description: json['description'],
      mediaURL: List<String>.from(json['mediaURL']),
      likes: List<String>.from(json['likes']),
      comments: (json['comments'] as List<dynamic>)
          .map((commentData) => CommentModel.fromJson(commentData))
          .toList(),
      location: json['location'],
      isBlocked: json['isBlocked'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

