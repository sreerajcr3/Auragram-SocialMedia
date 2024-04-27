import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/follow_unfollow/bloc/follow_unfollow_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:aura/presentation/screens/profile/user_profile_new.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class Followers extends StatefulWidget {
  final dynamic users;
  const Followers({super.key, required this.users});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  bool? follow;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocConsumer(
        blocs: [context.watch<CurrentUserBloc>()],
        buildWhen: null,
        listener: (context, state) {
        
        },
        builder: (context, state) {
          follow =   state[0].currentUser.followingIdsList.contains(widget.users.user.id)
                      ? true
                      : false;
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
                        navigatorPush(
                            UserProfileSccreen(
                                user: widget.users.followersUsersList[index]),
                            context);
                      },
                      child: FollowersFollowingCard(follow: follow, widget: widget,index: index,),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: widget
                      .users.followingUsersList.length, 
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                      widget.users.followersUsersList[index].id == state[0].currentUser.user.id?indexChangeNotifier.value = 3:
                        navigatorPush(
                            UserProfileSccreen(
                                user: widget.users.followingUsersList[index]),
                            context);
                      },
                      child: ListTile(
                            trailing: InkWell(
                              onTap: () {
                                 follow!
                                        ? context
                                            .read<FollowUnfollowBloc>()
                                            .add(ToUnfollowEvent(
                                                userId: widget.users.user.id!))
                                        : context
                                            .read<FollowUnfollowBloc>()
                                            .add(TofollowEvent(
                                                userId: widget.users.user.id!));
                                    follow! ? false : true;
                          },
                          child: follow!
                                      ? followUnfollowButton(
                                          "Following", color: kgreen, follow)
                                      : followUnfollowButton("Follow", follow),),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(widget.users
                                        .followingUsersList[index].profilePic ==
                                    ""
                                ? demoProPic
                                : widget.users.followingUsersList[index]
                                    .profilePic),
                          ),
                          title: Text(
                              widget.users.followingUsersList[index].username)),
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

class FollowersFollowingCard extends StatelessWidget {
  const FollowersFollowingCard({
    super.key,
    required this.follow,
    required this.widget, required this.index,
  });

  final bool? follow;
  final Followers widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: InkWell(
        onTap: () {
            follow!
                      ? context
                          .read<FollowUnfollowBloc>()
                          .add(ToUnfollowEvent(
                              userId: widget.users.user.id!))
                      : context
                          .read<FollowUnfollowBloc>()
                          .add(TofollowEvent(
                              userId: widget.users.user.id!));
                  follow! ? false : true;
        },
        child: follow!
                    ? followUnfollowButton(
                        "Following", color: kgreen, follow)
                    : followUnfollowButton("Follow", follow),),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.users
                    .followersUsersList[index].profilePic ==
                ""
            ? demoProPic
            : widget
                .users.followersUsersList[index].profilePic),
      ),
      title: Text(
          widget.users.followersUsersList[index].username),
    );
  }
}
