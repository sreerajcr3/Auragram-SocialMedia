import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/follow_unfollow/bloc/follow_unfollow_bloc.dart';
import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/domain/api_repository/uset_repository/repository.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserProfile extends StatefulWidget {
  final dynamic user;

  const UserProfile({
    super.key,
    required this.user,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool? follow;
  String propic = '';
  @override
  void initState() {
    // ApiServiceUser.getFollowingList();
    context.read<GetUserBloc>().add(GetuserFetchEvent(userId: widget.user.id!));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: BlocConsumer<CurrentUserBloc, CurrentUserState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CurrentUserSuccessState) {
            print("name is ${state.currentUser.user.fullname}");
            return SingleChildScrollView(
              child: BlocConsumer<GetUserBloc, GetUserState>(
                listener: (context, getuserstate) {},
                builder: (context, getuserstate) {
                  //###########################            setting    value to the follow variable               #######################################
                  follow = state.currentUser.followingIdsList
                          .contains(widget.user.id)
                      ? true
                      : false;

                  if (getuserstate is GetUserLoading) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height,
                      width: MediaQuery.sizeOf(context).width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: LoadingAnimationWidget.staggeredDotsWave(
                            color: kBlack,
                            size: 40,
                          )),
                        ],
                      ),
                    );
                  }
                  if (getuserstate is GetUsersuccessState) {
                    if (getuserstate.getUserModel.user.profilePic == "") {
                      propic = demoProPic;
                    } else {
                      propic = getuserstate.getUserModel.user.profilePic!;
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 300,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(), color: kGrey),
                                height: 200,
                                width: double.infinity,
                                child:
                                    getuserstate.getUserModel.user.coverPic ==
                                            " "
                                        ? Image.network(
                                            getuserstate
                                                .getUserModel.user.coverPic!,
                                            fit: BoxFit.cover,
                                          )
                                        : const Center(
                                            child: AppName(),
                                          )),
                            Positioned(
                              bottom: 20,
                              left: 10,
                              child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(propic)),
                            ),
                            Positioned(
                                top: 20,
                                left: 15,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.back,
                                    color: kBlack,
                                    size: 25,
                                  ),
                                )),
                            Positioned(
                                top: 20,
                                left: 60,
                                child: Text(
                                  getuserstate.getUserModel.user.username!,
                                  style: TextStyle(fontSize: 18, color: kGrey),
                                )),
                            BlocConsumer<FollowUnfollowBloc,
                                FollowUnfollowState>(
                              listener: (context, followState) {
                                if (followState is FollowUpdatedState) {
                                  context.read<GetUserBloc>().add(
                                      GetuserFetchEvent(
                                          userId: widget.user.id!));
                                }
                              },
                              builder: (context, followState) {
                                print(
                                    "getUser id  = ${getuserstate.getUserModel.user.id}");

                                print(
                                    "currentUser followers list = ${state.currentUser.followingIdsList}");
                                if (followState is FollowUpdatedState) {
                                  return Positioned(
                                      top: MediaQuery.sizeOf(context).height /
                                          3.9,
                                      right: MediaQuery.sizeOf(context).width *
                                          .18,

                                      // follow = getuserstate
                                      //     .getUserModel.user.followers!
                                      //     .contains(state.currentUser.user.id);

                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              // follow = !follow!;
                                              print(
                                                  "setstate followww  - $follow");
                                            });
                                            follow!
                                                ? context
                                                    .read<FollowUnfollowBloc>()
                                                    .add(ToUnfollowEvent(
                                                        userId: widget.user.id))
                                                : context
                                                    .read<FollowUnfollowBloc>()
                                                    .add(TofollowEvent(
                                                        userId:
                                                            widget.user.id));
                                          },
                                          child: !follow!
                                              ? followUnfollowButton("Follow",
                                                  color: kgreen)
                                              : followUnfollowButton(
                                                  "Unfollow")));
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // kheight20,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.user.fullname!,
                                      style: const TextStyle(
                                          fontFamily: "kanit", fontSize: 20),
                                    ),

                                    // Text(
                                    //   "Personal blog",
                                    //   style: TextStyle(fontSize: 16),
                                    // )
                                  ],
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child:
                                    Text(getuserstate.getUserModel.user.bio!),
                              ),
                              kheight15,
                              Card(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        profileText1(getuserstate
                                                .getUserModel.posts.isEmpty
                                            ? "0"
                                            : getuserstate
                                                .getUserModel.posts.length),
                                        profileCardText2('Post')
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        profileText1(getuserstate.getUserModel
                                                .user.following!.isEmpty
                                            ? "0"
                                            : getuserstate.getUserModel.user
                                                .following!.length
                                                .toString()),
                                        profileCardText2('Followers')
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        profileText1(getuserstate.getUserModel
                                                .user.followers!.isEmpty
                                            ? "0"
                                            : getuserstate.getUserModel.user
                                                .followers!.length
                                                .toString()),
                                        profileCardText2('Following')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // ProfileFollowersCountCard(
                              //   state: getuserstate.getUserModel.user,
                              // ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const Card(
                          margin: EdgeInsets.only(top: 1),
                          child: Center(
                            heightFactor: 0.5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18),
                              child: Text('Posts',
                                  style: TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: 20,
                                      fontFamily: 'kanit',
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        getuserstate.getUserModel.posts.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      getuserstate.getUserModel.posts.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 1,
                                    mainAxisSpacing: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 20,
                                      color: Colors
                                          .grey, // Adjust the color as needed
                                      alignment: Alignment.center,
                                      child: Image.network(
                                        getuserstate.getUserModel.posts[index]
                                            .mediaURL![0],
                                        fit: BoxFit.fitWidth,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(
                                height: 300,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Ionicons.camera_outline,
                                      size: 30,
                                    ),
                                    kwidth10,
                                    Center(
                                        child: Text(
                                      'No Post available',
                                      style: TextStyle(
                                          fontSize: 22, fontFamily: 'kanit'),
                                    )),
                                  ],
                                ))
                      ],
                    );
                  } else {
                    return const Text("user fetch failed");
                  }
                },
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Container followUnfollowButton(text, {color = kWhite}) {
    return Container(
      decoration:
          BoxDecoration(color: kBlack, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        child: Text(
          text,
          style: TextStyle(color: color, fontFamily: "kanit"),
        ),
      ),
    );
  }
}
