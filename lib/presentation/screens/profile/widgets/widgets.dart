import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/post/saved_post_detail_page.dart';
import 'package:aura/presentation/screens/profile/followers_page.dart';
import 'package:aura/presentation/screens/post/post_detail.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

//-----------------------profile following text----------------

profileCardText2(text) => Text(
      text,
      style: const TextStyle(fontSize: 16,color: Colors.black54),
    );

profileText1(text) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Text(
      text.toString(),
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color:kBlack),
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
              profileText1(
                  state.posts.length == 0 ? "0" : state.posts.length),
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
      
          return     savedpostsState.savedPosts.posts.isNotEmpty? SizedBox(
            height: MediaQuery.sizeOf(context).height, // Adjust the height as needed
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
                        onTap: () =>
                            navigatorPush(const SavedPostDetailPage(), context),
                        child: Image.network(
                          savedpostsState.savedPosts.posts[index].mediaURL[0],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  kheight30
                ],
              ),
            ),
          ): emptyMessage();
        } else {
          return Container();
        }
      },
    );
  }
}

Container followUnfollowButton(text, follow, {color = kWhite}) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: !follow
              ? [Colors.blueAccent, Colors.lightBlueAccent]
              : [Colors.greenAccent, Colors.greenAccent],
        ),
        borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 6),
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
            style: TextStyle(fontSize: 22, fontFamily: 'kanit',),
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
    var height = MediaQuery.sizeOf(context).height;
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
  Text bioProfileScreen(text ) {
    return Text(
                   text,
                    style: const TextStyle(fontSize: 15),
                  );
  }

  Text fullNameUserProfile(text ) {
    return Text(text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700));
  }

    Text usernameUserProfile(text) => Text("@$text",style:const TextStyle(color: kGreyDark),);

