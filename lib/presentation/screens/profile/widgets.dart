//-----------------------profile following text----------------
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

profileCardText2(text) => Text(
      text,
      style: TextStyle(fontSize: 16),
    );

profileText1(text) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Text(
      text.toString(),
      style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: "kanit",
          color: Colors.black54),
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
  const ProfileFollowersCountCard({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              profileText1(state.posts!.length == 0
                  ? "0"
                  : state.posts.length),
              profileCardText2('Post')
            ],
          ),
          Column(
            children: [
              profileText1(state.following!.isEmpty
                  ? "0"
                  : state.following!.length.toString()),
              profileCardText2('Followers')
            ],
          ),
          Column(
            children: [
              profileText1(state.followers!.isEmpty
                  ? "0"
                  : state.followers!.length.toString()),
              profileCardText2('Following')
            ],
          ),
        ],
      ),
    );
  }
}

SizedBox profileButton(
    {required Widget child,  void Function()? onPressed}) {
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
          return SizedBox(
            height: 500, // Adjust the height as needed
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
                      return Container(
                        color: Colors.grey, // Adjust the color as needed
                        alignment: Alignment.center,
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}
