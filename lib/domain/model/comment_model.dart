import 'package:aura/domain/model/user_model.dart';

class CommentModel {
  final String? id;
  final String ?comment;
  final User ?user;
  final String? createdAt;

  CommentModel({
     this.id,
     this.comment,
     this.user,
     this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['_id'],
      comment: json['comment'],
      user: User.fromJson(json['userId']),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'comment': comment,
      'userId': user!.toJson(),
      'createdAt': createdAt,
    };
  }
}
