import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/bloc/like_unlike_bloc/bloc/like_unlike_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/cubit/duration_cubit/cubit/duration_cubit.dart';
import 'package:aura/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';

class ExplorePostDetailPage extends StatefulWidget {
  final int intialIndex;
  const ExplorePostDetailPage({
    super.key, required this.intialIndex,
  });

  @override
  State<ExplorePostDetailPage> createState() => _ExplorePostDetailPageState();
}

class _ExplorePostDetailPageState extends State<ExplorePostDetailPage> {
  @override
  void initState() {
    super.initState();
    print("DETAIL PAGE WORKED");
    context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
    context.read<PostsBloc>().add(PostsInitialFetchEvent());
  }

  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<DeletePostBloc, DeletePostState>(
        builder: (context, deleteState) {
          //######################       to update the state after delete    ##########################

          if (deleteState is DeletePostSuccessState) {
            // context.read<PostsBloc>().add(PostsInitialFetchEvent());
          }
          return SafeArea(
            child: MultiBlocConsumer(
              buildWhen: null,
              blocs: [
                context.watch<LikeUnlikeBloc>(),
                context.watch<CurrentUserBloc>()
              ],
              builder: (context, multistate) {
                if (multistate[0] is LikeCountUpdatedState) {
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
                                        } else if (state is PostLoadingState) {
                                          return shimmer();
                                        } else if (state is PostSuccessState) {
                                          return ListView.builder(
                                            controller: ScrollController(initialScrollOffset: widget.intialIndex==0?0:widget.intialIndex*550.0),
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
                                                                      .profilePic !=
                                                                  ''
                                                              ? state
                                                                  .posts[index]
                                                                  .user!
                                                                  .profilePic!
                                                              : demoProPic,
                                                        ),
                                                      ),
                                                      kwidth10,

                                                      //#########################  navigating the page to the user profile    ##########################################

                                                      // ######################################   Post Icon Row #####################################

                                                      InkWell(
                                                        onTap: () =>
                                                            indexChangeNotifier
                                                                .value = 3,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              state
                                                                  .posts[index]
                                                                  .user!
                                                                  .username!,
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Text(
                                                              state.posts[index]
                                                                  .location
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color:
                                                                      kGreyDark),
                                                            )
                                                          ],
                                                        ),
                                                      ),

                                                      const Spacer(),
                                                      postDeleteIcon(
                                                          context,
                                                          multistate[1]
                                                              .currentUser,
                                                          index)
                                                    ],
                                                  ),
                                                  kheight5,
                                                  Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight: state
                                                              .posts[index]
                                                              .mediaURL![0]
                                                              .contains("image")
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
                                                      date: state
                                                          
                                                          .posts[index]
                                                          .createdAt!),
                                                  kheight15
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          return loading();
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
    );
  }
}
