import 'package:aura/domain/model/user_model.dart';

class Chat {
  final String id;
  final User sender;
  final User receiver;
  final String message;
  final String createdAt;
  final String updatedAt;

  Chat({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['_id'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      message: json['message'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'message': message,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}