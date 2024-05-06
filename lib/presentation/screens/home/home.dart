import 'dart:async';

import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/bloc/saved_post/bloc/save_post_bloc.dart';
import 'package:aura/cubit/duration_cubit/cubit/duration_cubit.dart';
import 'package:aura/domain/socket/socket.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
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
    final userID = getTheUserId();
    SocketService().connectSocket(context);
    
    print("userIdd === ${userID}");
    final durationCubit = DurationCubit();
    Timer(const Duration(seconds: 3), () {
      durationCubit.loading(true);
    });
    context.read<PostsBloc>().add(PostsInitialFetchEvent());
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    context.read<SavePostBloc>().add(FetchsavedPostEvent());

    super.initState();
  }

  getTheUserId() async {
    // final id = await getUserID();
    // print('id is-$id');
    // return id;
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
                                finished
                                    ? BlocConsumer<PostsBloc, PostsState>(
                                        listener: (context, state) {},
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
                                                return homePageMainContents(
                                                    state,
                                                    index,
                                                    commentController);
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
