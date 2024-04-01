import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class UserProfile extends StatefulWidget {
  final dynamic user;
  const UserProfile({super.key, required this.user});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
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
                            widget.user.username,
                            style: TextStyle(fontSize: 18, color: kGrey),
                          )),
                      Positioned(
                        top: MediaQuery.sizeOf(context).height / 3.5,
                        right: MediaQuery.sizeOf(context).width * .05,
                        child: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: const Text('Follow')),
                            kwidth10,
                            ElevatedButton(
                                onPressed: () {},
                                child: const Icon(Ionicons.chatbox)),
                          ],
                        ),
                      )
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
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(widget.user.bio?? "Add Bio"),
                        ),
                        kheight15,

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
                          fit: BoxFit.fitWidth,
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
