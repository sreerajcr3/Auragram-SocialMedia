import 'dart:async';

import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/cubit/duration_cubit/cubit/duration_cubit.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:aura/presentation/screens/profile/UserProfile.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Future<List<Posts>> post;
  late final VideoPlayerController videoPlayerController;
  final commentController = TextEditingController();
  String postId = '';
  String userId = '';
  final Map map = {};
  bool loading = false;
  final post = Posts(likes: []);
  bool saved = true;

  @override
  void initState() {
    final durationCubit = DurationCubit();
    Timer(const Duration(seconds: 20), () {
      durationCubit.loading(true);
    });
    context.read<PostsBloc>().add(PostsInitialFetchEvent());
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    context.read<SavePostBloc>().add(FetchsavedPostEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: Drawer(
        child: TextButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialogue(
                title: const Text(
                  "Log out",
                ),
                content: const Text("Do you really want to log out?"),
                onPressed: () {
                  logOut(context);
                },
              ),
            );
          },
          icon: const Icon(Icons.logout),
          label: const Text('Log out'),
        ),
      ),
      appBar: AppBar(
        title: const AppName(),
      ),
      body: BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
        builder: (context, _) {
          if (_ is LikeCountUpdatedState) {
            return BlocBuilder<DurationCubit, bool>(
              builder: (context, finished) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      finished
                          ? SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children:
                                    List.generate(10, (index) => storyCircle()),
                              ),
                            )
                          : skeltonStory(),
                      finished
                          ? BlocConsumer<PostsBloc, PostsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is PostErrorState) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is PostLoadingState) {
                                  return shimmer();
                                } else if (state is PostSuccessState) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.posts.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Card(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          elevation: 10,
                                          color: kWhite,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        state
                                                                .posts[index]
                                                                .user!
                                                                .profilePic!
                                                                .isNotEmpty
                                                            ? state
                                                                .posts[index]
                                                                .user!
                                                                .profilePic!
                                                            : "https://i.pinimg.com/564x/20/c0/0f/20c00f0f135c950096a54b7b465e45cc.jpg",
                                                      ),
                                                    ),
                                                    kwidth10,
                                                    InkWell(
                                                      onTap: () =>
                                                          navigatorPush(
                                                              UserProfile(
                                                                user: state
                                                                    .posts[
                                                                        index]
                                                                    .user,
                                                              ),
                                                              context),
                                                      child: Text(
                                                        state.posts[index].user!
                                                            .username!,
                                                        style:
                                                            const TextStyle(),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      onPressed: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return CustomAlertDialogue(
                                                                  title: const Text(
                                                                      "Delete"),
                                                                  content:
                                                                      const Text(
                                                                    "Do you want to delete this post",
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    context
                                                                        .read<
                                                                            DeletePostBloc>()
                                                                        .add(DeleteEvent(
                                                                            id: state.posts[index].id!));
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                            });
                                                      },
                                                      icon: const Icon(
                                                          Icons.more_vert),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxHeight: state.posts[index]
                                                          .mediaURL![0]
                                                          .contains("image")
                                                      ? 300
                                                      : 200,
                                                ), // Adjust as needed
                                                child: PageView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: state.posts[index]
                                                      .mediaURL!.length,
                                                  itemBuilder:
                                                      (context, pageIndex) {
                                                    postId =
                                                        state.posts[index].id!;
                                                    userId = state
                                                        .posts[index].user!.id!;
                                                    final mediaUrl = state
                                                        .posts[index]
                                                        .mediaURL![pageIndex];
                                                    return Container(
                                                        child: mediaUrl
                                                                .contains(
                                                                    "image")
                                                            ? Image.network(
                                                                mediaUrl,
                                                                fit: BoxFit
                                                                    .cover,
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
                                                            : VideoPlayerWIdget(
                                                                mediaUrl:
                                                                    mediaUrl));
                                                  },
                                                ),
                                              ),
                                              BlocBuilder<CurrentUserBloc,
                                                      CurrentUserState>(
                                                  builder:
                                                      (context, userState) {
                                                if (userState
                                                    is CurrentUserSuccessState) {
                                                  return Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () {
                                                            if (!state
                                                                .posts[index]
                                                                .likes!
                                                                .contains(userState
                                                                    .currentUser
                                                                    .user
                                                                    .id)) {
                                                              state.posts[index]
                                                                  .likes!
                                                                  .add(userState
                                                                      .currentUser
                                                                      .user
                                                                      .id!);
                                                              context
                                                                  .read<
                                                                      LikeUnlikeBloc>()
                                                                  .add(
                                                                    LikeAddEvent(
                                                                        id: state
                                                                            .posts[index]
                                                                            .id!),
                                                                  );
                                                            } else {
                                                              state.posts[index]
                                                                  .likes!
                                                                  .remove(userState
                                                                      .currentUser
                                                                      .user
                                                                      .id!);
                                                              context
                                                                  .read<
                                                                      LikeUnlikeBloc>()
                                                                  .add(
                                                                    UnlikeEvent(
                                                                        id: state
                                                                            .posts[index]
                                                                            .id!),
                                                                  );
                                                            }
                                                          },
                                                          child: !state
                                                                  .posts[index]
                                                                  .likes!
                                                                  .contains(
                                                                      userState
                                                                          .currentUser
                                                                          .user
                                                                          .id!)
                                                              ? const Icon(Ionicons
                                                                  .heart_outline)
                                                              : const Icon(
                                                                  Ionicons
                                                                      .heart)),
                                                      postIconButton(
                                                        Ionicons
                                                            .chatbubble_outline,
                                                        () {
                                                          commentBottomSheet(
                                                              context,
                                                              state,
                                                              index,
                                                              commentController);
                                                        },
                                                      ),
                                                      postIconButton(
                                                          Ionicons
                                                              .paper_plane_outline,
                                                          () {}),
                                                      const Spacer(),
                                                      BlocBuilder<SavePostBloc,
                                                          SavePostState>(
                                                        builder: (context,
                                                            savedPostevent) {
                                                          if (savedPostevent
                                                              is FetchedSavedPostsState) {
                                                            if (savedPostevent.savedPostsList.posts.contains(state.posts[index].id)) {
                                                              print('yeesssss');
                                                              return IconButton(
                                                                  onPressed:
                                                                      () {
                                                                           context
                                                                      .read<
                                                                          SavePostBloc>()
                                                                      .add(ToSavePostEvent(
                                                                          postId:
                                                                              postId));
                                                                      },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .bookmark,
                                                                  ));
                                                            } else {
                                                              return const Text(
                                                                  'data');
                                                            }
                                                          } else {
                                                            return IconButton(
                                                                onPressed: () {
                                                                  context
                                                                      .read<
                                                                          SavePostBloc>()
                                                                      .add(ToSavePostEvent(
                                                                          postId:
                                                                              postId));
                                                                },
                                                                icon:
                                                                    const Icon(
                                                                  Icons
                                                                      .bookmark_added,
                                                                ));
                                                          }
                                                          // return postIconButton(
                                                          //     Icons.bookmark,
                                                          //     () => null);
                                                        },
                                                      )
                                                    ],
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }),
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      state.posts[index].likes!
                                                              .isEmpty
                                                          ? Container()
                                                          : Text(
                                                              '${state.posts[index].likes!.length} ${state.posts[index].likes!.length != 1 ? 'likes' : 'like'}',
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'kanit',
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                      Text(
                                                        state.posts[index].user!
                                                            .username!,
                                                        style: const TextStyle(
                                                            fontFamily: "kanit",
                                                            fontSize: 18),
                                                      ),
                                                      Text(state.posts[index]
                                                          .description!),
                                                      state
                                                                  .posts[index]
                                                                  .comments!
                                                                  .length >
                                                              1
                                                          ? InkWell(
                                                              onTap: () =>
                                                                  commentBottomSheet(
                                                                      context,
                                                                      state,
                                                                      index,
                                                                      commentController),
                                                              child: Text(
                                                                "View all ${state.posts[index].comments!.length.toString()} comments",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .blueGrey),
                                                              ),
                                                            )
                                                          : Container(),
                                                      Date(
                                                          date: state
                                                              .posts[index]
                                                              .createdAt!),
                                                    ],
                                                  )),
                                              kheight15
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return const Text('oops');
                                }
                              },
                            )
                          : shimmer()
                    ],
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
