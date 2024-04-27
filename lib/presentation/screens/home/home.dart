import 'dart:async';

import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/commonData/common_data.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/cubit/duration_cubit/cubit/duration_cubit.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:aura/presentation/screens/profile/user_profile_new.dart';
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
  late final VideoPlayerController videoPlayerController;
  final commentController = TextEditingController();
  String postId = '';
  String userId = '';
  final Map likedUsersMap = {};

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

  Future<void> refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<PostsBloc>().add(PostsInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      endDrawer: Drawer(
        child: logoutIcon(context),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const AppName(),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: BlocBuilder<DeletePostBloc, DeletePostState>(
          builder: (context, deleteState) {
            //######################       to update the state after delete    ##########################

            if (deleteState is DeletePostSuccessState) {
              // context.read<PostsBloc>().add(PostsInitialFetchEvent());
            }
            return SafeArea(
              child: BlocBuilder<LikeUnlikeBloc, LikeUnlikeState>(
                builder: (context, _) {
                  if (_ is LikeCountUpdatedState) {
                    return BlocBuilder<DurationCubit, bool>(
                      builder: (context, finished) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // AppName(),
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
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(child: loading()),
                                              ],
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
                                                          radius: 20,
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
                                                        BlocBuilder<
                                                            CurrentUserBloc,
                                                            CurrentUserState>(
                                                          builder: (context,
                                                              userState) {
                                                            if (userState
                                                                is CurrentUserSuccessState) {
                                                              // ######################################   Post Icon Row #####################################

                                                              return InkWell(
                                                                onTap: () => state
                                                                            .posts[
                                                                                index]
                                                                            .user!
                                                                            .id ==
                                                                        userState
                                                                            .currentUser
                                                                            .user
                                                                            .id
                                                                    ? indexChangeNotifier
                                                                        .value = 3
                                                                    : navigatorPush(
                                                                        UserProfileSccreen(
                                                                          user: state
                                                                              .posts[index]
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
                                                                              FontWeight.w500),
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
                                                              );
                                                            } else {
                                                              return Container();
                                                            }
                                                          },
                                                        ),

                                                        // const Spacer(),
                                                        // postDeleteIcon(context,
                                                        //     state, index)
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
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    kheight5,
                                                    Date(
                                                        date: state.posts[index]
                                                            .createdAt!),
                                                    kheight5,
                                                    editedList.contains(state
                                                            .posts[index].id!)
                                                        ? const Text(
                                                            'edited',
                                                            style: TextStyle(
                                                                color:
                                                                    kGreyDark),
                                                          )
                                                        : Container(),
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
      ),
    );
  }
}
