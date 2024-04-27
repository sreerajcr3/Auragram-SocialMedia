import 'dart:async';

import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/follow_unfollow/bloc/follow_unfollow_bloc.dart';
import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/domain/model/get_user_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/profile/get_user_post_detailpage.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class UserProfileSccreen extends StatefulWidget {
  final User user;

  const UserProfileSccreen({super.key, required this.user});

  @override
  State<UserProfileSccreen> createState() => _UserProfileSccreenState();
}

class _UserProfileSccreenState extends State<UserProfileSccreen> {
  GetUserModel? fetchedUser;
  List followers = [];

  @override
  void initState() {
    context.read<GetUserBloc>().add(GetuserFetchEvent(userId: widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: customAppbar(
          text: "Profile",
          context: context,
          onPressed: () {},
          icon: Container()),
      body: MultiBlocConsumer(
        blocs: [
          context.watch<CurrentUserBloc>(),
          context.watch<GetUserBloc>(),
          context.watch<FollowUnfollowBloc>(),
        ],
        buildWhen: null,
        listenWhen: null,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FollowUpdatedState ||
              state is! FollowUpdatedState ||
              state is GetUsersuccessState) {
            fetchedUser = state[1].getUserModel;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: height / 2.6,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width,
                              height: height / 5,
                              child: fetchedUser!.user.coverPic == ""
                                  ? Image.asset(
                                      "assets/images/AURAGRAM Cover phot.jpg",
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      fetchedUser!.user.coverPic!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 150,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: height,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [kGrey, kWhite]),
                              // color: Colors.yellow,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                          )),
                      Positioned(
                          top: height / 8,
                          left: 30,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                state[1].getUserModel.user.profilePic ??
                                    demoProPic),
                            radius: 50,
                          )),
                      Positioned(
                        top: height / 3.7,
                        left: 20,
                        child: Text(
                          widget.user.fullname!,
                          style: const TextStyle(
                            fontFamily: "JosefinSans",
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 3.2,
                        left: 20,
                        child: Text(
                          state[1].getUserModel.user.bio!,
                          style: const TextStyle(
                            fontFamily: "kanit",
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 4.9,
                        right: MediaQuery.sizeOf(context).width * .03,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () async {
                                context.read<GetUserBloc>().add(
                                    GetuserFetchEvent(userId: widget.user.id!));
                                for (var element
                                    in state[1].getUserModel.user.followers) {
                                  followers.add(element['_id']);
                                }
                                final User currentuser =
                                    state[0].currentUser.user;
                                // }

                                // followers =
                                //    await state[1].getUserModel.user.followers;
                                bool follow = state[1]
                                    .getUserModel
                                    .user
                                    .followers
                                    .contains(currentuser.id);

                                follow = followers.contains(currentuser.id);

                                if (!follow) {
                                  context.read<FollowUnfollowBloc>().add(
                                      TofollowEvent(userId: widget.user.id!));
                                } else {
                                  //  followers.removeWhere((element) =>element["_id"] == currentuser.id);

                                  context.read<FollowUnfollowBloc>().add(
                                      ToUnfollowEvent(userId: widget.user.id!));
                                }
                                StreamSubscription<FollowUnfollowState>
                                    subscription = context
                                        .read<FollowUnfollowBloc>()
                                        .stream
                                        .listen((state) {
                                  if (state is FollowSuccesssFullState) {
                                    followers.add(currentuser.id);
                                    context.read<GetUserBloc>().add(
                                        GetuserFetchEvent(
                                            userId: widget.user.id!));
                                  } else if (state
                                      is UnFollowSuccesssFullState) {
                                    followers.remove(currentuser.id);
                                    context.read<GetUserBloc>().add(
                                        GetuserFetchEvent(
                                            userId: widget.user.id!));
                                  }
                                });
                                context
                                    .read<FollowUnfollowBloc>()
                                    .add(FollowUpdateEvent());
                              },
                              child: state[1]
                                          .getUserModel
                                          .user
                                          .followers
                                          .contains(
                                              state[0].currentUser.user.id) ||
                                      followers.contains(
                                          state[0].currentUser.user.id)
                                  ? followUnfollowButton(
                                      "Following", color: kgreen, true)
                                  : followUnfollowButton("Follow", false),
                            ),
                            kwidth10,
                            Container(
                                alignment: Alignment.topCenter,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  // color: kBlack,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: containerButton(
                                    "Message", () => null, Colors.transparent))
                          ],
                        ),
                      )
                    ],
                  ),
                  profileCountCard(state[1], context, followers.length),
                  state[1].getUserModel.posts.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state[1].getUserModel.posts.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => navigatorPush(
                                    GetuserPostDetailPage(
                                        user: state[1].getUserModel.user),
                                    context),
                                child: Image.network(
                                  state[1]
                                      .getUserModel
                                      .posts[index]
                                      .mediaURL![0],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        )
                      : emptyMessage()
                ],
              ),
            );
          } else {
            return loading();
          }
        },
      ),
    );
  }
}


