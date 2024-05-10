import 'dart:io';

import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/post/saved_post_detail_page.dart';
import 'package:aura/presentation/screens/profile/edit_profile.dart';
import 'package:aura/presentation/screens/profile/followers_page.dart';
import 'package:aura/presentation/screens/post/post_detail.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';
import 'package:shimmer/shimmer.dart';

//-----------------------profile following text----------------

profileCardText2(text) => Text(
      text,
      style: const TextStyle(fontSize: 16,),
    );

profileText1(text) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Text(
      text.toString(),
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold,),
    ),
  );
}

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
            foregroundColor: const MaterialStatePropertyAll(kBlack),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Follow',
            style: TextStyle(
              color: kWhite,
            ),
          ),
        ),
        kwidth20,
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {},
          child: const Icon(CupertinoIcons.envelope),
        ),
      ],
    );
  }
}

class ProfileFollowersCountCard extends StatelessWidget {
  final dynamic state;
  final bool currentUser;
  const ProfileFollowersCountCard({
    super.key,
    required this.state,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigatorPush(
            Followers(
              users: state,
              currentUser: currentUser,
            ),
            context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              profileText1(state.posts.length == 0 ? "0" : state.posts.length),
              profileCardText2('Post')
            ],
          ),
          Column(
            children: [
              profileText1(state.user.following!.isEmpty
                  ? "0"
                  : state.user.following!.length.toString()),
              profileCardText2('Following')
            ],
          ),
          Column(
            children: [
              profileText1(state.user.followers!.isEmpty
                  ? "0"
                  : state.user.followers!.length.toString()),
              profileCardText2('Followers')
            ],
          ),
        ],
      ),
    );
  }
}

SizedBox profileButton({required Widget child, void Function()? onPressed}) {
  return SizedBox(
      // width: width,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
          onPressed: onPressed,
          child: child));
}

class SavedPostGrid extends StatelessWidget {
  final dynamic state;

  const SavedPostGrid({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavePostBloc, SavePostState>(
      listener: (context, savedpostsState) {},
      builder: (context, savedpostsState) {
        if (savedpostsState is FetchedSavedPostsState) {
          return savedpostsState.savedPosts.posts.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.sizeOf(context)
                      .height, // Adjust the height as needed
                  child: Expanded(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: savedpostsState.savedPosts.posts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => navigatorPush(
                                  const SavedPostDetailPage(), context),
                              child: Image.network(
                                savedpostsState
                                    .savedPosts.posts[index].mediaURL[0],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        kheight30
                      ],
                    ),
                  ),
                )
              : emptyMessage();
        } else {
          return Container();
        }
      },
    );
  }
}

Container followUnfollowButton(text, follow,
    {color = kWhite, horizontal = 60.0, vertical = 6.0}) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: !follow
              ? [Colors.blueAccent, Colors.lightBlueAccent]
              : [Colors.greenAccent, Colors.greenAccent],
        ),
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, color: kWhite),
      ),
    ),
  );
}

SizedBox emptyMessage() {
  return const SizedBox(
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
              fontSize: 22,
              fontFamily: 'kanit',
            ),
          )),
        ],
      ));
}

profileCountCard(getuserstate, context, followersLength, currentUserbool) {
  return InkWell(
    onTap: () {
      navigatorPush(
          Followers(
            users: getuserstate.getUserModel,
            currentUser: currentUserbool,
          ),
          context);
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            profileText1(getuserstate.getUserModel.posts.isEmpty
                ? "0"
                : getuserstate.getUserModel.posts.length),
            profileCardText2('Post')
          ],
        ),
        Column(
          children: [
            profileText1(getuserstate.getUserModel.user.following!.isEmpty
                ? "0"
                : getuserstate.getUserModel.user.following!.length.toString()),
            profileCardText2('Following')
          ],
        ),
        Column(
          children: [
            profileText1(getuserstate.getUserModel.user.followers!.isEmpty
                ? "0"
                : getuserstate.getUserModel.followersUsersList.length
                    .toString()),
            profileCardText2('Followers')
          ],
        ),
      ],
    ),
  );
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
        // height: 300, // Adjust the height as needed

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
                    return InkWell(
                      onTap: () =>
                          navigatorPush(const PostDetailPage(), context),
                      child: Image.network(
                        state.currentUser.posts[index].mediaURL![0],
                        fit: BoxFit.cover,
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
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  )),
                ],
              )));
  }
}

Shimmer shimmerProfile() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ttb,
    enabled: true,
    baseColor: kGrey,
    highlightColor: Colors.white,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return const SkeletonProfilel();
      },
    ),
  );
}

class SkeletonProfilel extends StatelessWidget {
  const SkeletonProfilel({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: customAppbar(text: "Profile", context: context, onPressed: () {}),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
                  color: kWhite,
                ),
                Positioned(
                  top: 200,
                  child: Container(
                    height: MediaQuery.sizeOf(context).height / 1.4,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: const BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                    top: 150,
                    left: 40,
                    child: CircleAvatar(
                      radius: 50,
                    )),
                Positioned(
                  left: 20,
                  top: 270,
                  child: Container(
                    height: 20,
                    width: 150,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 310,
                  child: Container(
                    height: 20,
                    width: 240,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 360,
                  child: Container(
                    height: 80,
                    width: width - 50,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 480,
                  child: Container(
                    height: 40,
                    width: width - 50,
                    decoration: BoxDecoration(
                      color: kWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    height: 80,
                    width: 80,
                    color: kWhite,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Text bioProfileScreen(text,context) {
  return Text(
    text,
    style:  TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.primary,),
  );
}

Text fullNameUserProfile(text,context) {
  return Text(text,
      style:  TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Theme.of(context).colorScheme.secondary,));
}
Text fullNameUserPostCard(text,context) {
  return Text(text,
      style:  TextStyle(fontSize: 20,color: Theme.of(context).colorScheme.secondary, ));
}
Text descriptionPostCard( state, int index,text,context) {
  return Text(
      text,
      style:  TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary,),
    );
}

Text usernameUserProfile(text) => Text(
      "@$text",
      style: const TextStyle(color: kGreyDark),
    );

Column entireProfileContent(BuildContext context, CurrentUserSuccessState state,
    double screenHeight, double screenWidth) {
  return Column(
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
                // color: Theme.of(context).colorScheme.onSecondary,
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
              radius: 51,
              backgroundColor: kWhite,
              child: CircleAvatar(
                radius: 48,
                backgroundImage: state.currentUser.user.profilePic != ""
                    ? NetworkImage(state.currentUser.user.profilePic!)
                    : const NetworkImage(demoProPic),
              ),
            ),
          ),
        ],
      ),
      fullNameUserProfile(state.currentUser.user.fullname!,context),
      usernameUserProfile(state.currentUser.user.username),
      kheight15,
      bioProfileScreen(state.currentUser.user.bio!,context),
      kheight15,
      ProfileFollowersCountCard(
        state: state.currentUser,
        currentUser: true,
      ),
      kheight15,
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: containerTextButton(
            "Edit Profile",
            () => navigatorPush(
                EditProfile(user: state.currentUser.user), context),
            Theme.of(context).colorScheme.secondary,context,
            textColor:  Theme.of(context).colorScheme.primary,),
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
  );
}

pickProfilePic() async {
  final XFile? pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  return File(pickedImage!.path);
}

pickCoverPic() async {
  final XFile? pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  return File(pickedImage!.path);
}

class FollowersFollowingCard extends StatelessWidget {
  const FollowersFollowingCard({
    super.key,
    required this.widget,
    required this.index,
  });

  final Followers widget;
  final int index;

  @override
  Widget build(BuildContext context) {
    return MultiBlocConsumer(
      blocs: [context.watch<CurrentUserBloc>(), context.watch<GetUserBloc>()],
      buildWhen: null,
      builder: (p0, state) {
        if (state[1] is GetUsersuccessState) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(state[1]
                          .getUserModel
                          .followersUsersList[index]
                          .profilePic ==
                      ""
                  ? demoProPic
                  : state[1].getUserModel.followersUsersList[index].profilePic),
            ),
            title:
                Text(state[1].getUserModel.followersUsersList[index].username),
          );
        } else {
          return loading();
        }
      },
    );
  }
}
