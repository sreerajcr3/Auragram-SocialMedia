import 'dart:async';

import 'package:aura/bloc/Posts/bloc/posts_bloc.dart';
import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/cubit/duration_cubit/cubit/duration_cubit.dart';
import 'package:aura/domain/model/post_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/home/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
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
  late Future<List<Posts>> post;
  late final VideoPlayerController videoPlayerController;
  bool loading = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 20), () {
      context.read<DurationCubit>().loading(true);
    });
    context.read<PostsBloc>().add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: Drawer(
          child: TextButton.icon(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Log out'),
                      content: const Text("Do you really want to log out?"),
                      actions: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Text("cancel")),
                        IconButton(
                            onPressed: () {
                              logOut(context);
                            },
                            icon: const Text("ok")),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log out'),
          ),
        ),
        appBar: AppBar(
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         navigatorPush (const Profile(me: true,), context);
          //       },
          //       icon: Icon(Icons.portable_wifi_off_outlined))
          // ],
          title: const AppName(),
        ),
        body: BlocBuilder<DurationCubit, bool>(
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
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.posts.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      elevation: 10,
                                      color: Colors.grey[100],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(state
                                                                .posts[index]
                                                                .user!
                                                                .profilePic! ??
                                                            "https://i.pinimg.com/564x/20/c0/0f/20c00f0f135c950096a54b7b465e45cc.jpg")),
                                                kwidth10,
                                                Text(
                                                  state.posts[index].user!
                                                      .username!,
                                                  style: const TextStyle(),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Delete'),
                                                            content: const Text(
                                                                "Do you really want to delete?"),
                                                            actions: [
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon: const Text(
                                                                      "cancel")),
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    context
                                                                        .read<
                                                                            DeletePostBloc>()
                                                                        .add(DeleteEvent(
                                                                            id: state.posts[index].id));
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  icon:
                                                                      const Text(
                                                                          "ok")),
                                                            ],
                                                          );
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
                                              maxHeight: state
                                                      .posts[index].mediaURL[0]
                                                      .contains("image")
                                                  ? 300
                                                  : 200,
                                            ), // Adjust as needed
                                            child: PageView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: state
                                                  .posts[index].mediaURL.length,
                                              itemBuilder:
                                                  (context, pageIndex) {
                                                final mediaUrl = state
                                                    .posts[index]
                                                    .mediaURL[pageIndex];
                                                return Container(
                                                    child: mediaUrl
                                                            .contains("image")
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
                                                        : buildVideoPlayer(
                                                            mediaUrl));
                                              },
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Ionicons.heart_outline),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Ionicons
                                                    .chatbubble_outline),
                                              ),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(Ionicons
                                                    .paper_plane_outline),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    CupertinoIcons.bookmark),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.posts[index].user!
                                                      .username!,
                                                  style: const TextStyle(
                                                      fontFamily: "kanit",
                                                      fontSize: 18),
                                                ),
                                                Text(state
                                                    .posts[index].description),
                                                state.posts[index].comments
                                                            .length >
                                                        1
                                                    ? Text(
                                                        "View all ${state.posts[index].comments.length.toString()}",
                                                        style: const TextStyle(
                                                            color: Colors
                                                                .blueGrey),
                                                      )
                                                    : Container(),
                                                Date(
                                                    date: state.posts[index]
                                                        .createdAt),
                                              ],
                                            ),
                                          ),
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
        ));
  }
}
