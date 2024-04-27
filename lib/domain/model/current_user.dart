import 'package:aura/domain/model/post_model.dart';
import 'package:aura/domain/model/user_model.dart';

class CurrentUser {
  final User user;
  final List<Posts> posts;
  final List followingIdsList;
  final List followingUsersList;
  final List<User> followersUsersList;

  CurrentUser({
    required this.user,
    required this.posts,
    required this.followingIdsList,
    required this.followingUsersList,
    required this.followersUsersList,
  });
}
