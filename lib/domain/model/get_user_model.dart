import 'package:aura/domain/model/post_model.dart';
import 'package:aura/domain/model/user_model.dart';

class GetUserModel {
   final User user;
  final List<Posts> posts;

  GetUserModel({required this.user, required this.posts});
}