import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/profile/edit_profile.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        appBar:customAppbar(text: "My Profile", context: context, onPressed: (){},leadingIcon: true),
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
                        Container(
                          height: 350,
                          width: double.infinity,
                          // color: Colors.orange,
                        ),
                      
                        Positioned(
                            child: Container(
                          height: 200,
                          width: MediaQuery.sizeOf(context).width,
                          color: Colors.green,
                          child: state.currentUser.user.coverPic!= ""?Image.network(state.currentUser.user.coverPic!):Image.asset("assets/images/AURAGRAM Cover phot.jpg",fit: BoxFit.cover,),
                        )),
                        Positioned(
                          top: 180,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            height: 160,
                            width: MediaQuery.sizeOf(context).width,
                          ),
                        ),
                        Positioned(
                          top: 150,
                          left: 30,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                state.currentUser.user.profilePic != ""
                                    ? NetworkImage(
                                        state.currentUser.user.profilePic!)
                                    : const NetworkImage(demoProPic),
                          ),
                        ),
                        Positioned(
                          top: 210,
                          right: 70,
                          child: containerButton("Edit Profile", () {
                            navigatorPush(
                              EditProfile(
                                user: state.currentUser.user,
                              ),
                              context,
                            );
                          }, kBlack, textColor: kWhite),
                        ),
                        Positioned(
                          left: 20,
                          top: 270,
                          child: Text(
                            state.currentUser.user.fullname!,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const Positioned(
                          left: 20,
                          top: 305,
                          child: Text(
                            // state.currentUser.user.bio!,
                            "hi",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    ProfileFollowersCountCard(
                      state: state.currentUser,
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
