class SavedPosts {
  final String id;
  final String userId;
  final List<PostModelSavePost> posts;
  final String createdAt;
  final String updatedAt;

  SavedPosts({
    required this.id,
    required this.userId,
    required this.posts,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SavedPosts.fromJson(Map<String, dynamic> json) {
    final List<dynamic> postsData = json['saved-posts']['posts'] ?? [];
    List<PostModelSavePost> postsList = postsData.map((postData) {
      return PostModelSavePost.fromJson(postData);
    }).toList();

    return SavedPosts(
      id: json['saved-posts']['_id'] ?? '',
      userId: json['saved-posts']['userId'] ?? '',
      posts: postsList,
      createdAt: json['saved-posts']['createdAt'] ?? '',
      updatedAt: json['saved-posts']['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> postsJsonList = posts.map((post) => post.toJson()).toList();

    return {
      'saved-posts': {
        '_id': id,
        'userId': userId,
        'posts': postsJsonList,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      }
    };
  }
}

class PostModelSavePost {
  final String id;
  final String userId;
  final String description;
  final List<String> mediaURL;
  final List<String> likes;
  final List<String> comments;
  final String location;
  final bool isBlocked;
  final String createdAt;
  final String updatedAt;

  PostModelSavePost({
    required this.id,
    required this.userId,
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
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      description: json['description'] ?? '',
      mediaURL: List<String>.from(json['mediaURL'] ?? []),
      likes: List<String>.from(json['likes'] ?? []),
      comments: List<String>.from(json['comments'] ?? []),
      location: json['location'] ?? '',
      isBlocked: json['isBlocked'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'description': description,
      'mediaURL': mediaURL,
      'likes': likes,
      'comments': comments,
      'location': location,
      'isBlocked': isBlocked,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
