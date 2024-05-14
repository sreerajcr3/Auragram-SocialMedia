import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/commonData/common_data.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/cubit/password_cubit/password_cubit.dart';
import 'package:aura/domain/model/comment_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class TextformField extends StatelessWidget {
  final String labelText;
  final String? valueText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  const TextformField({
    super.key,
    required this.labelText,
    required this.controller,
    this.valueText,
    this.prefixIcon,
    this.suffixIcon,
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
            prefixIcon: Icon(prefixIcon),
            suffixIcon: Icon(suffixIcon),
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
class TextformFieldWithRegEx extends StatelessWidget {
  final String labelText;
 final String? Function(String?)? validator;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  const TextformFieldWithRegEx({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator:validator,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcon),
            suffixIcon: Icon(suffixIcon),
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

class PasswordTextFormFeild extends StatefulWidget {
  final String labelText;
  final String? valueText;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  const PasswordTextFormFeild({
    super.key,
    required this.labelText,
    required this.controller,
    this.valueText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<PasswordTextFormFeild> createState() => _PasswordTextFormFeildState();
}

class _PasswordTextFormFeildState extends State<PasswordTextFormFeild> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PasswordCubit, bool>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return '${widget.valueText} is required*';
              }
              return null;
            },
            controller: widget.controller,
            obscureText: obscureText,
            decoration: InputDecoration(
                prefixIcon: Icon(widget.prefixIcon),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(obscureText ? Ionicons.eye : Ionicons.eye_off)),
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
                labelText: widget.labelText),
          ),
        );
      },
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
            Size(MediaQuery.sizeOf(context).width / 1.1, 65)),
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
    width: MediaQuery.sizeOf(context).width / 1.1,
    height: 65,
    color: kBlack,
    child: Center(
      child: loading2(context),
    ),
  );
}

class AppName extends StatelessWidget {
  const AppName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "illuminate",
      style: TextStyle(
          fontFamily:"kanit",
          fontSize: 30,
          // fontWeight: FontWeight.bold
          ),
    );
  }
}

//----------------------------------------comment widget----------------------------------------
Future<dynamic> commentBottomSheet(BuildContext context, state, int index,
    TextEditingController commentController, userSuccessState) {
  List<CommentModel> commentList = [];
  return showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: true,
    context: context,
    builder: (ctx) {
      return Column(
        children: [
          kheight20,
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
          kheight20,
          BlocConsumer<CommentBloc, CommentState>(
            buildWhen: null,
            listenWhen: null,
            listener: (context, multistate) {
              if (multistate is CommentUpdateState) {
                // context.read<PostsBloc>().add(PostsInitialFetchEvent());
              }
            },
            builder: (context, multistate) {
              commentList = state.posts[index].comments;

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
                              final comment = CommentModel(
                                  id: state.posts[index].id!,
                                  comment: commentController.text,
                                  createdAt: DateTime.now().toString(),
                                  user: User(
                                      username: userSuccessState
                                          .currentUser.user.username,
                                      id: userSuccessState.currentUser.user.id,
                                      profilePic: userSuccessState
                                          .currentUser.user.profilePic));
                              commentList.add(comment);
                              context.read<CommentBloc>().add(
                                    AddCommentEvent(
                                        postId: state.posts[index].id!,
                                        comment: commentController.text),
                                  );

                              context
                                  .read<CommentBloc>()
                                  .add(CommentUpdateEvent());

                              commentController.clear();
                            },
                            child: const SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  kwidth10,
                                  Text(
                                    'Post',
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )),
                        hintText: 'Add a comment',
                      ),
                    ),
                  ),
                  kwidth10
                ],
              );
              // } else {
              //   return loading();
              // }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: state.posts[index].comments.isNotEmpty
                  ? BlocBuilder<CommentBloc, CommentState>(
                      builder: (context, _) {
                        // if (_ is CommentUpdateState) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: commentList.length,
                          itemBuilder: (context, commentIndex) {
                            DateTime dateTime = DateTime.parse(state
                                .posts[index]
                                .comments![commentIndex]
                                .createdAt);
                            //user in comments
                            final user = commentList[commentIndex].user;

                            //comments
                            final comment = commentList[commentIndex];

                            return ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        user!.profilePic != ''
                                            ? user.profilePic!
                                            : demoProPic)),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.username!,
                                        style: const TextStyle(fontSize: 15)),
                                    Text(
                                      comment.comment!,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      timeago.format(dateTime, locale: 'en'),
                                    ),
                                  ],
                                ),
                                trailing: comment.user!.id! ==
                                        userSuccessState.currentUser.user.id
                                    ? IconButton(
                                        onPressed: () {
                                          context
                                              .read<PostsBloc>()
                                              .add(PostsInitialFetchEvent());

                                          context.read<CommentBloc>().add(
                                                DeleteCommentEvent(
                                                  postId:
                                                      state.posts[index].id!,
                                                  commentId: comment.id!,
                                                ),
                                              );
                                          commentList.removeWhere((element) =>
                                              element.id == comment.id);
                                        },
                                        icon: const Icon(CupertinoIcons.delete),
                                      )
                                    : const SizedBox());
                          },
                        );
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
      postLikeCount(
          state.posts[index].likes!.length.toString(),
          state.posts[index].likes!.length > 1 ? "likes" : "like",
          index,
          context),
      postIconButton(Ionicons.chatbubble_outline,
          onPressed: () => commentBottomSheet(
              context, state, index, commentController, userState)),
      postLikeCount(
          state.posts[index].comments!.length.toString(),
          state.posts[index].likes!.length > 1 ? "comments" : "comment",
          index,
          context),
      const Spacer(),
      BlocConsumer<SavePostBloc, SavePostState>(listener: (context, saveState) {
        if (saveState is SavePostSuccessState) {
          context.read<SavePostBloc>().add(FetchsavedPostEvent());
        }
      }, builder: (context, saveState) {
        if (saveState is FetchedSavedPostsState) {
          if (!savedPosts.containsKey(userState.currentUser.user.id)) {
            savedPosts[userState.currentUser.user.id!] = {};
          }

          return savedPosts[userState.currentUser.user.id]!
                  .contains(state.posts[index].id!)
              ? IconButton(
                  onPressed: () {
                    savedPosts[userState.currentUser.user.id!]!
                        .remove(state.posts[index].id!);

                    context
                        .read<SavePostBloc>()
                        .add(UnsavePostEvent(postId: state.posts[index].id!));
                  },
                  icon: Icon(
                    Icons.bookmark,
                    color: Theme.of(context).colorScheme.primary,
                    size: 27,
                  ))
              : IconButton(
                  onPressed: () {
                    savedPosts[userState.currentUser.user.id!]!
                        .add(state.posts[index].id!);
                    context
                        .read<SavePostBloc>()
                        .add(ToSavePostEvent(postId: state.posts[index].id!));
                  },
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Theme.of(context).colorScheme.primary,
                    size: 27,
                  ));
        }

        return IconButton(
            onPressed: () {
              savedPosts[userState.currentUser.user.id!]!
                  .add(state.posts[index].id!);
              context
                  .read<SavePostBloc>()
                  .add(ToSavePostEvent(postId: state.posts[index].id!));
            },
            icon: Icon(
              Icons.bookmark_border,
              color: Theme.of(context).colorScheme.primary,
              size: 27,
            ));
      })
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
      foregroundColor: Theme.of(context).colorScheme.secondary,
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

AppBar customAppbarChatPage({
  required String fullname,
  required BuildContext context,
  required String profilePic,
}) {
  return AppBar(
    foregroundColor: Theme.of(context).colorScheme.secondary,
    backgroundColor: Colors.transparent,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage:
              NetworkImage(profilePic != "" ? profilePic : demoProPic),
        ),
        kwidth20,
        Text(fullname),
      ],
    ),
  );
}

Text postLikeCount(text, item, int index, context) {
  return Text(
    "$text $item",
    style: TextStyle(
      fontSize: 15,
      color: Theme.of(context).colorScheme.secondary,
    ),
  );
}

PageView postPageView(state, int index) {
  return PageView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: state.posts[index].mediaURL!.length,
    itemBuilder: (context, pageIndex) {
      final mediaUrl = state.posts[index].mediaURL![pageIndex];
      return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: mediaUrl.contains("image")
              ? Image.network(
                  mediaUrl,
                  fit: BoxFit.cover,
                )
              : VideoPlayerWIdget(mediaUrl: mediaUrl));
    },
  );
}

loading() {
  return Center(
      child: LoadingAnimationWidget.dotsTriangle(color: kBlack, size: 35));
}

loading2(context) {
  return Center(
      child: Padding(
    padding: const EdgeInsets.only(right: 10),
    child:
        LoadingAnimationWidget.horizontalRotatingDots(color: kWhite, size: 25),
  ));
}

containerButton(icon, Function() onTap, bg, {textColor = Colors.black}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Icon(
                icon,
                color: Colors.white,
              ))),
    ),
  );
}

containerTextButton(text, Function() onTap, bg, context,
    {textColor = Colors.black}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(),
      ),
      child: Center(
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                text,
                style: const TextStyle(
                  color: kWhite,
                ),
              ))),
    ),
  );
}

Column topRowPostCard(PostSuccessState state, int index, context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        state.posts[index].user!.username!,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      Text(
        state.posts[index].location.toString(),
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.secondary,
        ),
      )
    ],
  );
}
