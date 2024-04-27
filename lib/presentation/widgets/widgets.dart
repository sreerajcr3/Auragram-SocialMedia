import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/screens/Image_picker/functions/functions_and_widgets.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class TextformField extends StatelessWidget {
  final String labelText;
  final String? valueText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  const TextformField({
    super.key,
    required this.labelText,
    required this.controller,
    this.valueText,
    this.prefixIcon,
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
            prefixIcon: Icon(prefixIcon) ?? null,
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide()),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
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
              fontSize: 45,
              fontWeight: FontWeight.w600,
            ),
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
              fontSize: 35,
              fontWeight: FontWeight.w900,
            ),
          ),
          kheight20,
          Text(
            subText,
            style: const TextStyle(fontSize: 18),
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
          
         Size( MediaQuery.sizeOf(context).width/1.1 ,65)
        ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), 
            ),
          ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
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
Future<dynamic> commentBottomSheet(BuildContext context,  state,
    int index, commentController,  userSuccessState) {
  return showModalBottomSheet(
    isDismissible: true,
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
                borderRadius: BorderRadius.circular(10),
                color: kGreyDark,
              ),
            ),
          ),
          BlocConsumer<CommentBloc, CommentState>(
            buildWhen: null,
            listenWhen: null,
            listener: (context, multistate) {
              if (multistate is CommentUpdateState) {
                context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
                context.read<PostsBloc>().add(PostsInitialFetchEvent());
              }
            },
            builder: (context, multistate) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            userSuccessState.currentUser.user.profilePic != ''
                                ? userSuccessState.currentUser.user.profilePic!
                                : demoProPic)),
                  ),
                  kwidth10,
                  Expanded(
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        suffix: InkWell(
                            onTap: () {
                              context.read<CommentBloc>().add(
                                    AddCommentEvent(
                                        postId: state.posts[index].id!,
                                        comment: commentController.text),
                                  );
                              print("post cliked");
                            },
                            child: const Text('Post')),
                        hintText: 'Add a comment',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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
                                    context.read<CommentBloc>().add(
                                          DeleteCommentEvent(
                                            postId: state.posts[index].id!,
                                            commentId: comment.id!,
                                          ),
                                        );
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        user!.profilePic != ''
                                            ? user.profilePic!
                                            : demoProPic)),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.username!,
                                        style: const TextStyle(fontSize: 20)),
                                    Text(comment.comment!),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  : const SizedBox(
                      height: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'No comments yet',
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Text('Start a conversation'),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      );
    },
  );
}

Row postIconRow(state, int index, CurrentUserSuccessState userState,
    BuildContext context, commentController) {
      context.read<SavePostBloc>().add(FetchsavedPostEvent());
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

      postLikeCount(state.posts[index].likes!.length.toString(),
          state.posts[index].likes!.length > 1 ? "likes" : "like", index),

      postIconButton(Ionicons.chatbubble_outline,
          onPressed: () => commentBottomSheet(
              context, state, index, commentController, userState)),
      postLikeCount(state.posts[index].comments!.length.toString(),
          state.posts[index].likes!.length > 1 ? "comments" : "comment", index),
      // postIconButton(
      //   Ionicons.paper_plane_outline,
      // ),
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
                Icons.abc,
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
        }
      )
    ],
  );
}

AppBar customAppbar(
    {required String text,
    required BuildContext context,
    required void Function() onPressed,
    Widget? icon,
    bool leadingIcon = false}) {
  List<Widget> appBarActions = [];

  // Add the icon button if the icon is provided
  if (icon != null) {
    appBarActions.add(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: InkWell(
          onTap: onPressed,
          child: icon,
        ),
      ),
    );
  }
  return AppBar(
      actions: appBarActions,
      title: Text(
        text,
        style: const TextStyle(fontFamily: "JosefinSans", fontSize: 18),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: !leadingIcon
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_sharp),
            )
          : Container());
}

Text postLikeCount(text, item, int index) {
  return Text(
    "$text $item",
    style: const TextStyle(fontSize: 15),
  );
}

PageView postPageView(state, int index) {
  return PageView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: state.posts[index].mediaURL!.length,
    itemBuilder: (context, pageIndex) {
      // postId = state.posts[index].id!;
      // userId = state.posts[index].user!.id!;
      final mediaUrl = state.posts[index].mediaURL![pageIndex];
      return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.green),
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

loading() {
  return Center(
      child: LoadingAnimationWidget.dotsTriangle(color: kBlack, size: 35));
}

containerButton(text, Function() onTap, bg, {textColor = Colors.black}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(7),
          border: Border.all()),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 20),
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      )),
    ),
  );
}
