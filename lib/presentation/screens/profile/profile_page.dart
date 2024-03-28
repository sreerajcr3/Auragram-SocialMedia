import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/edit_profile.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  final bool me;
  const Profile({super.key, required this.me});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
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
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      const SizedBox(
                        width: double.infinity,
                        // color: Colors.green,
                        height: 300,
                      ),
                      Container(
                          decoration:
                              BoxDecoration(border: Border.all(), color: kGrey),
                          // color: Colors.blue,
                          height: 200,
                          width: double.infinity,
                          // color: Colors.blue,
                          child: state.currentUser.user.coverPic != null
                              ? Image.network(
                                  state.currentUser.user.coverPic!,
                                  fit: BoxFit.cover,
                                )
                              : const Center(child: Text('Add Cover photo'))),
                      Positioned(
                        bottom: 20,
                        left: 10,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundImage: NetworkImage(
                            state.currentUser.user.profilePic!,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 35,
                          right: !widget.me ? 40 : 75,
                          child: widget.me == false
                              ? const UserProfileButton()
                              : ElevatedButton(
                                  style: const ButtonStyle(),
                                  onPressed: () {
                                    navigatorPush(const EditProfile(), context);
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
                          child: Text(state.currentUser.user.bio ?? "Add Bio"),
                        ),
                        kheight15,
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  profileText1(state.currentUser.posts.isEmpty
                                      ? "0"
                                      : state.currentUser.posts.length
                                          .toString()),
                                  profileCardText2('Post')
                                ],
                              ),
                              Column(
                                children: [
                                  profileText1(state
                                          .currentUser.user.following!.isEmpty
                                      ? "0"
                                      : state.currentUser.user.followers!.length
                                          .toString()),
                                  profileCardText2('Followers')
                                ],
                              ),
                              Column(
                                children: [
                                  profileText1(state
                                          .currentUser.user.following!.isEmpty
                                      ? "0"
                                      : state.currentUser.user.following!.length
                                          .toString()),
                                  profileCardText2('Following')
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.currentUser.posts.isEmpty
                        ? 0
                        : state.currentUser.posts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        width: 20,
                        color: Colors.grey, // Adjust the color as needed
                        alignment: Alignment.center,
                        child: Image.network(
                          state.currentUser.posts[index].mediaURL![0],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )
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
    );
  }
}
