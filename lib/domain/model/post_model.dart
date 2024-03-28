import 'package:aura/domain/model/user_model.dart';

class Posts {
  final User? user;
  final String? description;
  final String? id;
  final List<String>? mediaURL;
  final String? location;
  final List<dynamic>? likes;
  final List<dynamic>? comments;
  final bool? isBlocked;
  final String? createdAt;
  final String? updatedAt;

  Posts({
     this.user,
     this.description,
     this.id,
     this.mediaURL,
     this.location,
     this.likes,
     this.comments,
     this.isBlocked,
     this.createdAt,
     this.updatedAt,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
      user: json['userId'] is Map<String, dynamic> ? User.fromJson(json['userId']) : User(),
      description: json['description'],
      id:json['_id'],
      mediaURL: List<String>.from(json['mediaURL']),
      location: json['location'],
      likes: List<dynamic>.from(json['likes']),
      comments: List<dynamic>.from(json['comments']),
      isBlocked: json['isBlocked'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': user is Map<String, dynamic> ? user!.toJson() : User(),
      'description': description,
      '_id':id,
      'mediaURL': mediaURL,
      'location': location,
      'likes': likes,
      'comments': comments,
      'isBlocked': isBlocked,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
