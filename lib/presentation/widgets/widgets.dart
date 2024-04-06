import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/screens/Image_picker/functions/functions_and_widgets.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class TextformField extends StatelessWidget {
  final String labelText;
  final String? valueText;
  final TextEditingController controller;
  const TextformField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return '$valueText is required*';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide()),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide()), // border: const OutlineInputBorder(),
            labelText: labelText),
      ),
    );
  }
}

class TItleHeading extends StatelessWidget {
  final String text1;
  final String? text2;
  final String subText;
  const TItleHeading({
    super.key,
    required this.subText,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: const TextStyle(
                fontSize: 45, fontWeight: FontWeight.w600, fontFamily: 'kanit'),
          ),
          //   AnimatedTextKit(
          //  isRepeatingAnimation: false,
          //  pause: Duration(seconds: 0),
          //     animatedTexts: [
          //     FadeAnimatedText(text1, textStyle: TextStyle()),
          //   ]),

          Text(
            text2!,
            style: const TextStyle(
                fontSize: 35, fontWeight: FontWeight.w900, fontFamily: 'kanit'),
          ),
          kheight20,
          Text(
            subText,
            style: const TextStyle(fontFamily: "kanit", fontSize: 18),
          )
        ],
      ),
    );
  }
}

//-------------------------------button--------------------------

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(
            kBlack,
          ),
          foregroundColor: const MaterialStatePropertyAll(kWhite),
          fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(MediaQuery.sizeOf(context).width * 0.9))),
      child: Text(
        text,
        style: const TextStyle(fontFamily: "kanit", fontSize: 18),
      ),
    );
  }
}

demoButton(context) {
  return Container(
    width: MediaQuery.sizeOf(context).width * 0.9,
    height: 10,
    color: kBlack,
  );
}

class AppName extends StatelessWidget {
  const AppName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Auragram",
      style: TextStyle(
          fontFamily: "DancingScript",
          fontSize: 40,
          fontWeight: FontWeight.bold),
    );
  }
}

//----------------------------------------comment widget----------------------------------------
Future<dynamic> commentBottomSheet(BuildContext context, PostSuccessState state,
    int index, commentController) {
  return showModalBottomSheet(
      isDismissible: true,
      // isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 100,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kGreyDark),
              ),
            ),
            postTextfield("Add a comment", commentController,
                button: ElevatedButton(
                    onPressed: () {
                      context.read<CommentBloc>().add(AddCommentEvent(
                          postId: state.posts[index].id!,
                          comment: commentController.text));
                    },
                    child: const Text('Post'))),
            Expanded(
              child: SingleChildScrollView(
                child: state.posts[index].comments!.length != 0
                    ? BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, _) {
                        if (_ is CommentUpdateState) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.posts[index].comments!.length,
                            itemBuilder: (context, commentIndex) {
                              //user in comments
                              final user = state
                                  .posts[index].comments![commentIndex].user;

                              //comments
                              final comment =
                                  state.posts[index].comments![commentIndex];

                              return ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      context
                                          .read<CommentBloc>()
                                          .add(DeleteCommentEvent(
                                            postId: state.posts[index].id!,
                                            commentId: comment.id!,
                                          ));
                                    },
                                    icon: const Icon(Icons.clear)),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user!.profilePic!),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.username!,
                                        style: TextStyle(
                                            fontFamily: 'kanit', fontSize: 20)),
                                    Text(comment.comment!),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      })
                    : const SizedBox(
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              'No comments yet',
                              style:
                                  TextStyle(fontSize: 22, fontFamily: 'kanit'),
                            )),
                            Text("start a conversation")
                          ],
                        ),
                      ),
              ),
            ),
          ],
        );
      });
}

Row postIconRow(
    PostSuccessState state,
    int index,
    CurrentUserSuccessState userState,
    BuildContext context,
    commentController) {
  bool saved = false;

  return Row(
    children: [
      GestureDetector(
          onTap: () {
            if (!state.posts[index].likes!
                .contains(userState.currentUser.user.id)) {
              state.posts[index].likes!.add(userState.currentUser.user.id!);
              context.read<LikeUnlikeBloc>().add(
                    LikeAddEvent(id: state.posts[index].id!),
                  );
            } else {
              state.posts[index].likes!.remove(userState.currentUser.user.id!);
              context.read<LikeUnlikeBloc>().add(
                    UnlikeEvent(id: state.posts[index].id!),
                  );
            }
          },
          child: !state.posts[index].likes!
                  .contains(userState.currentUser.user.id!)
              ? postIconButton(Ionicons.heart_outline)
              : postIconButton(Ionicons.heart, color: kred)),
      postIconButton(Ionicons.chatbubble_outline,
          onPressed: () =>
              commentBottomSheet(context, state, index, commentController)),
      postIconButton(
        Ionicons.paper_plane_outline,
      ),
      const Spacer(),
      BlocConsumer<SavePostBloc, SavePostState>(
        listener: (context, saveState) {
          if (saveState is SavePostSuccessState) {
            context.read<SavePostBloc>().add(FetchsavedPostEvent());
          }
        },
        builder: (context, saveState) {
          if (saveState is FetchedSavedPostsState) {
            print("savedpostlist = = ${saveState.savedPosts.posts}");
            for (var i = 0; i < saveState.savedPosts.posts.length; i++) {
              if (saveState.savedPosts.posts[i].id == state.posts[index].id) {
                saved = true;
              } else {
                saved = false;
              }
            }
            return saved
                ? IconButton(
                    onPressed: () {
                      saved = false;
                      context
                          .read<SavePostBloc>()
                          .add(UnsavePostEvent(postId: state.posts[index].id!));
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      size: 27,
                    ))
                : IconButton(
                    onPressed: () {
                      saved = true;
                      context
                          .read<SavePostBloc>()
                          .add(ToSavePostEvent(postId: state.posts[index].id!));
                    },
                    icon: const Icon(
                      Icons.bookmark_border,
                      size: 27,
                    ));
          }
          // if (saveState is PostSuccessState) {
          //   return IconButton(onPressed: (){
          //      context
          //                 .read<
          //                     SavePostBloc>()
          //                 .add(UnsavePostEvent(
          //                     postId: state.posts[index].id!));
          //   }, icon:  const Icon(
          //               Icons
          //                   .bookmark_added));
          // }
          // else if(state is UnSavePostSuccessState){
          //    return IconButton(onPressed: (){
          //      context
          //                 .read<
          //                     SavePostBloc>()
          //                 .add(ToSavePostEvent(
          //                     postId: state.posts[index].id!));
          //   }, icon:  const Icon(
          //               Icons
          //                   .bookmark_outline));
          // }
          return const Padding(
              padding: EdgeInsets.only(right: 11),
              child: Icon(
                Icons.bookmark_border,
                size: 27,
              ));

          // if (saveState
          //     is SavePostSuccessState) {
          //   return const Icon(Icons
          //       .bookmark);
          // } else {
          //   return const Icon(
          //       Icons.bookmark_outline);
          // }
        },
      )
    ],
  );
}

PageView postPageView(PostSuccessState state, int index) {
  return PageView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: state.posts[index].mediaURL!.length,
    itemBuilder: (context, pageIndex) {
      // postId = state.posts[index].id!;
      // userId = state.posts[index].user!.id!;
      final mediaUrl = state.posts[index].mediaURL![pageIndex];
      return Container(
          child: mediaUrl.contains("image")
              ? Image.network(
                  mediaUrl,
                  fit: BoxFit.cover,
                )
              // : FlickVideoPlayer(
              //     flickManager: FlickManager(
              //       videoPlayerController:
              //           VideoPlayerController
              //               .networkUrl(
              //         Uri.parse(mediaUrl),
              //         httpHeaders: {
              //           "Authorization":
              //               "334583943739261"
              //         },
              //       ),
              //     ),
              //   ),
              : VideoPlayerWIdget(mediaUrl: mediaUrl));
    },
  );
}
