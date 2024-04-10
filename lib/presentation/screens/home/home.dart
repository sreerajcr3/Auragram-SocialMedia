import 'dart:async';

import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/cubit/duration_cubit/cubit/duration_cubit.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:aura/presentation/screens/profile/UserProfile.dart';
import 'package:aura/presentation/screens/profile/userProfileNew.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  bool saved = false;

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
        child: logoutIcon(context),
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   title: const AppName(),
      // ),
      body: BlocBuilder<DeletePostBloc, DeletePostState>(
        builder: (context, deleteState) {
          //######################       to update the state after delete    ##########################

          if (deleteState is DeletePostSuccessState) {
            context.read<PostsBloc>().add(PostsInitialFetchEvent());
          }
          return SafeArea(
            child: BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
              builder: (context, _) {
                if (_ is LikeCountUpdatedState) {
                  return BlocBuilder<DurationCubit, bool>(
                    builder: (context, finished) {
                      return SingleChildScrollView(
                        child: GestureDetector(
                          onLongPressStart: (details) => print("swipe"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                AppName(),
                                // finished
                                //     ? SingleChildScrollView(
                                //         scrollDirection: Axis.horizontal,
                                //         child: Row(
                                //           children:
                                //               List.generate(10, (index) => storyCircle()),
                                //         ),
                                //       )
                                //     : skeltonStory(),
                                finished
                                    ? BlocConsumer<PostsBloc, PostsState>(
                                        listener: (context, state) {
                                          // context
                                          //     .read<PostsBloc>()
                                          //     .add(PostsInitialFetchEvent());
                                        },
                                        builder: (context, state) {
                                          if (state is PostErrorState) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (state
                                              is PostLoadingState) {
                                            return shimmer();
                                          } else if (state
                                              is PostSuccessState) {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: state.posts.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        kwidth10,
                                                        CircleAvatar(
                                                          radius: 23,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            state
                                                                    .posts[
                                                                        index]
                                                                    .user!
                                                                    .profilePic!
                                                                    .isNotEmpty
                                                                ? state
                                                                    .posts[
                                                                        index]
                                                                    .user!
                                                                    .profilePic!
                                                                : demoProPic,
                                                          ),
                                                        ),
                                                        kwidth10,

                                                        //#########################  navigating the page to the user profile    ##########################################

                                                        InkWell(
                                                          onTap: () =>
                                                              navigatorPush(
                                                                  UserProfileSccreen(
                                                                    user: state
                                                                        .posts[
                                                                            index]
                                                                        .user!,
                                                                  ),
                                                                  context),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                state
                                                                    .posts[
                                                                        index]
                                                                    .user!
                                                                    .username!,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              Text(
                                                                state
                                                                    .posts[
                                                                        index]
                                                                    .location
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color:
                                                                        kGreyDark),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                        const Spacer(),
                                                        postDeleteIcon(context,
                                                            state, index)
                                                      ],
                                                    ),
                                                    kheight5,
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxHeight: state
                                                                .posts[index]
                                                                .mediaURL![0]
                                                                .contains(
                                                                    "image")
                                                            ? 300
                                                            : 200,
                                                      ), // Adjust as needed

                                                      // ###################################        whole  post card ###########################################

                                                      child: postPageView(
                                                          state, index),
                                                    ),
                                                    BlocBuilder<CurrentUserBloc,
                                                        CurrentUserState>(
                                                      builder:
                                                          (context, userState) {
                                                        if (userState
                                                            is CurrentUserSuccessState) {
                                                          // ######################################   Post Icon Row #####################################

                                                          return postIconRow(
                                                              state,
                                                              index,
                                                              userState,
                                                              context,
                                                              commentController);
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    ),

                                                    Text(
                                                      state.posts[index].user!
                                                          .username!,
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    kheight5,
                                                    Text(
                                                      state.posts[index]
                                                          .description!,
                                                      style:const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    //     state
                                                    //                 .posts[
                                                    //                     index]
                                                    //                 .comments!
                                                    //                 .length >
                                                    //             1
                                                    //         ? InkWell(
                                                    //             onTap: () =>
                                                    //                 commentBottomSheet(
                                                    //                     context,
                                                    //                     state,
                                                    //                     index,
                                                    //                     commentController),
                                                    //             child: Text(
                                                    //               "View all ${state.posts[index].comments!.length.toString()} comments",
                                                    //               style: const TextStyle(
                                                    //                   color: Colors
                                                    //                       .blueGrey),
                                                    //             ),
                                                    //           )
                                                    //         : Container(),
                                                    kheight5,
                                                    Date(
                                                        date: state.posts[index]
                                                            .createdAt!),
                                                    //   ],
                                                    // )
                                                    //
                                                    // ),

                                                    kheight15
                                                  ],
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
                          ),
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
        },
      ),
    );
  }
}
