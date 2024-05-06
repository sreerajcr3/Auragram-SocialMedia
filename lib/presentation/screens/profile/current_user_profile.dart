import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/profile/edit_profile.dart';
import 'package:aura/presentation/screens/profile/settings.dart';
import 'package:aura/presentation/screens/profile/widgets/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

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
  Future<void> refreshProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customAppbar(
            icon: const Icon(Icons.menu),
            text: "My Profile",
            context: context,
            onPressed: () {
              navigatorPush(const SettingsPage(), context);
            },
            leadingIcon: true),
        body: RefreshIndicator(
          onRefresh: refreshProfile,
          child: BlocConsumer<CurrentUserBloc, CurrentUserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CurrentUserSuccessState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          const SizedBox(
                            height: 250,
                          ),
                          Positioned(
                              child: SizedBox(
                            height: 200,
                            width: MediaQuery.sizeOf(context).width,
                            child: state.currentUser.user.coverPic != ""
                                ? Image.network(
                                    state.currentUser.user.coverPic!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    demoCoverPic,
                                    fit: BoxFit.fill,
                                    width: MediaQuery.sizeOf(context).width,
                                  ),
                          )),
                          Positioned(
                            top: 180,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              height: 50,
                              width: MediaQuery.sizeOf(context).width,
                            ),
                          ),
                          Positioned(
                            top: screenHeight / 6,
                            left: screenWidth / 3,
                            right: screenWidth / 3,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  state.currentUser.user.profilePic != ""
                                      ? NetworkImage(
                                          state.currentUser.user.profilePic!)
                                      : const NetworkImage(demoProPic),
                            ),
                          ),
                        ],
                      ),
                      fullNameUserProfile(state.currentUser.user.fullname!),
                      usernameUserProfile(state.currentUser.user.username),
                      kheight15,
                      bioProfileScreen(state.currentUser.user.bio!),
                      kheight15,
                      ProfileFollowersCountCard(
                        state: state.currentUser,
                        currentUser: true,
                      ),
                      kheight15,
                      Padding(
                        padding:const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: containerTextButton(
                            "Edit Profile",
                            () => navigatorPush(
                                EditProfile(user: state.currentUser.user),
                                context),
                            kBlack,
                            textColor: kWhite),
                      ),
                      kheight20,
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            const TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(
                                  icon: Icon(Ionicons.grid),
                                ),
                                Tab(
                                  icon: Icon(Ionicons.bookmark),
                                ),
                              ],
                            ),
                            // TabBarView
                            SizedBox(
                              height: 400,
                              child: TabBarView(
                                children: [
                                  ProfilePostGrid(state: state),
                                  SavedPostGrid(state: state),
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
      ),
    );
  }
}
