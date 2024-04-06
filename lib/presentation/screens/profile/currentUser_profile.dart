import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/edit_profile.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class MyProfile extends StatefulWidget {
  final bool me;
  const MyProfile({super.key, required this.me});

  @override
  State<MyProfile> createState() => _ProfileState();
}

class _ProfileState extends State<MyProfile> {
  @override
  void initState() {
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    context.read<SavePostBloc>().add(FetchsavedPostEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          
          automaticallyImplyLeading: false,
        ),
        body: BlocConsumer<CurrentUserBloc, CurrentUserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is CurrentUserSuccessState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 300,
                        ),
                        Container(
                          decoration:
                              BoxDecoration(border: Border.all(), color: kGrey),
                          height: 200,
                          width: double.infinity,
                          child: state.currentUser.user.coverPic != null
                              ? Image.network(
                                  state.currentUser.user.coverPic!,
                                  fit: BoxFit.cover,
                                )
                              : const Center(
                                  child: Text('Add Cover photo'),
                                ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 10,
                          child: CircleAvatar(
                              radius: 70,
                              backgroundImage:
                                  state.currentUser.user.profilePic != ""
                                      ? NetworkImage(
                                          state.currentUser.user.profilePic!,
                                        )
                                      : const NetworkImage(demoProPic)),
                        ),
                        Positioned(
                            bottom: 35,
                            right: !widget.me ? 40 : 75,
                            child:
                                 ElevatedButton(
                                    style: const ButtonStyle(),
                                    onPressed: () {
                                      navigatorPush(
                                          const EditProfile(), context);
                                    },
                                    child: const Text(
                                      "Edit Profile",
                                      style: TextStyle(
                                        fontFamily: "kanit",
                                      ),
                                    ))),
                        Positioned(
                            top: 20,
                            left: 15,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                CupertinoIcons.back,
                                color: kGrey,
                                size: 25,
                              ),
                            )),
                        Positioned(
                            top: 20,
                            left: 60,
                            child: Text(
                              state.currentUser.user.username!,
                              style: TextStyle(fontSize: 18, color: kGrey),
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // kheight20,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.currentUser.user.fullname!,
                                      style: const TextStyle(
                                          fontFamily: "kanit", fontSize: 20),
                                    ),
                                    // Text(
                                    //   "Personal blog",
                                    //   style: TextStyle(fontSize: 16),
                                    // )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child:
                                Text(state.currentUser.user.bio ?? "Add Bio"),
                          ),
                          kheight15,
                          ProfileFollowersCountCard(
                            state: state.currentUser.user,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          const TabBar(
                            tabs: [
                              Tab(text: 'Posts'),
                              Tab(text: 'Saved'),
                            ],
                          ),
                          // TabBarView
                          SizedBox(
                            height: 400,
                            child: TabBarView(
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ProfilePostGrid(state: state),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SavedPostGrid(state: state),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class ProfilePostGrid extends StatelessWidget {
  final dynamic state;

  const ProfilePostGrid({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300, // Adjust the height as needed

        child: state.currentUser.posts.length != 0
            ? Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.currentUser.posts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey, // Adjust the color as needed
                      alignment: Alignment.center,
                      child: Image.network(
                        state.currentUser.posts[index].mediaURL![0],
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  },
                ),
              )
            : const SizedBox(
                // height: 100,
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
                    'No Posts',
                    style: TextStyle(fontSize: 22, fontFamily: 'kanit'),
                  )),
                ],
              )));
  }
}
