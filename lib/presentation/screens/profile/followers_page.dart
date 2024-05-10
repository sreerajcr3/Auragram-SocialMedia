import 'dart:async';

import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/follow_unfollow/bloc/follow_unfollow_bloc.dart';
import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/profile/current_user_profile.dart';
import 'package:aura/presentation/screens/profile/user_profile_new.dart';
import 'package:aura/presentation/screens/profile/widgets/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class Followers extends StatefulWidget {
  final dynamic users;
  final bool currentUser;
  const Followers({super.key, required this.users, required this.currentUser});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  List followingUsers = [];
  bool loading = true;

  @override
  void initState() {
    context
        .read<GetUserBloc>()
        .add(GetuserFetchEvent(userId: widget.users.user.id!));
    Timer(const Duration(seconds: 2), () {
      loading = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocConsumer(
        blocs: [
          context.watch<CurrentUserBloc>(),
          context.watch<FollowUnfollowBloc>(),
          context.watch<GetUserBloc>()
        ],
        buildWhen: null,
        listener: (context, state) {},
        builder: (context, state) {
          if (state[2] is GetUserLoading) {
            return Scaffold(
              body: Center(
                child: loading2(context),
              ),
            );
          }
          followingUsers = widget.users.followingUsersList;
      

          return Scaffold(
            appBar: AppBar(
              title: Text(widget.users.user.username),
              bottom: const TabBar(
                labelStyle: TextStyle(fontFamily: "JosefinSans", fontSize: 18),
                tabs: [
                  Tab(
                    text: "Followers",
                  ),
                  Tab(
                    text: "Following",
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListView.builder(
                  itemCount: widget.users.followersUsersList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        widget.users.followersUsersList[index].id ==
                                state[0].currentUser.user.id
                            ? navigatorPush(const MyProfile(), context)
                            : navigatorPush(
                                UserProfileSccreen(
                                    user:
                                        widget.users.followersUsersList[index]),
                                context);
                      },
                      child: FollowersFollowingCard(
                        widget: widget,
                        index: index,
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: followingUsers.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        widget.users.followingUsersList[index].id ==
                                state[0].currentUser.user.id
                            ? navigatorPush(const MyProfile(), context)
                            : navigatorPush(
                                UserProfileSccreen(
                                    user:
                                        widget.users.followingUsersList[index]),
                                context);
                      },
                      child: ListTile(
                        trailing: widget.currentUser
                            ? InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Text(
                                              "Unfollow ${followingUsers[index].username} ?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel")),
                                            TextButton(
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          FollowUnfollowBloc>()
                                                      .add(ToUnfollowEvent(
                                                          userId: widget
                                                              .users
                                                              .followingUsersList[
                                                                  index]
                                                              .id));
                                                  context
                                                      .read<
                                                          FollowUnfollowBloc>()
                                                      .add(FollowUpdateEvent());
                                                  followingUsers.removeWhere(
                                                      (element) =>
                                                          element.id ==
                                                          widget
                                                              .users
                                                              .followingUsersList[
                                                                  index]
                                                              .id);
                                                              Navigator.pop(context);
                                                },
                                                child: const Text("Ok"))
                                          ],
                                        );
                                      });
                                },
                                child: followUnfollowButton(
                                    "Following", color: kgreen, true,horizontal:30.0 ,vertical: 4.0))
                            : const SizedBox(
                                height: 1,
                                width: 1,
                              ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(widget.users
                                      .followingUsersList[index].profilePic ==
                                  ""
                              ? demoProPic
                              : widget
                                  .users.followingUsersList[index].profilePic),
                        ),
                        title: Text(followingUsers[index].username),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


