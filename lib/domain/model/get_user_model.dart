import 'package:aura/domain/model/post_model.dart';
import 'package:aura/domain/model/user_model.dart';

class GetUserModel {
   final User user;
  final List<Posts> posts;
  final List<User> followingUsersList;
  final List<User> followersUsersList;

  GetUserModel({required this.user, required this.posts,required this.followingUsersList, required this.followersUsersList, });
}