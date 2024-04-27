import 'package:aura/bloc/delete_post/bloc/delete_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/commonData/common_data.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/post/edit_post.dart';
import 'package:aura/presentation/screens/post/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

class Date extends StatelessWidget {
  final String date;
  const Date({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);

    // DateFormat formattedDate = DateFormat.yMMMd();
    // String finaldate = formattedDate.format(dateTime);

    return Text(
      timeago.format(dateTime, locale: 'en'),
      // timeago.setLocaleMessages('en', MyCustomMessages()),
      style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
    );
  }
}
// Override "en" locale messages with custom messages that are more precise and short
// timeago.setLocaleMessages('en', MyCustomMessages());

// my_custom_messages.dart
class MyCustomMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '${minutes}m';
  @override
  String minutes(int minutes) => '${minutes}m';
  @override
  String aboutAnHour(int minutes) => '${minutes}m';
  @override
  String hours(int hours) => '${hours}h';
  @override
  String aDay(int hours) => '${hours}h';
  @override
  String days(int days) => '${days}d';
  @override
  String aboutAMonth(int days) => '${days}d';
  @override
  String months(int months) => '${months}mo';
  @override
  String aboutAYear(int year) => '${year}y';
  @override
  String years(int years) => '${years}y';
  @override
  String wordSeparator() => ' ';
}

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(),
                kwidth10,
                Container(
                  decoration: BoxDecoration(
                      color: kWhite, borderRadius: BorderRadius.circular(20)),
                  width: 100,
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: kWhite, borderRadius: BorderRadius.circular(30)),
          ),
          kheight15,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(
                  color: kWhite, borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              height: 12,
              decoration: BoxDecoration(
                  color: kWhite, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              height: 12,
              decoration: BoxDecoration(
                  color: kWhite, borderRadius: BorderRadius.circular(10)),
            ),
          ),
          kheight15
        ],
      ),
    );
  }
}

class VideoPlayerWIdget extends StatefulWidget {
  final mediaUrl;
  const VideoPlayerWIdget({super.key, required this.mediaUrl});

  @override
  State<VideoPlayerWIdget> createState() => _VideoPlayerWIdgetState();
}

class _VideoPlayerWIdgetState extends State<VideoPlayerWIdget> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    //demo check video = https://www.youtube.com/watch?v=W6-O00alJUo
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.mediaUrl),
      httpHeaders: {"Authorization": "787284768575152"},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: VideoPlayer(videoPlayerController),
    );
  }
}

storyCircle() {
  return const Padding(
      padding: EdgeInsets.all(5.0),
      child: CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage(
            "https://i.pinimg.com/564x/20/c0/0f/20c00f0f135c950096a54b7b465e45cc.jpg"),
      ));
}

skeltonStory() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ltr,
    enabled: true,
    baseColor: kGrey,
    highlightColor: Colors.white,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            10,
            (index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    backgroundColor: kGrey,
                    radius: 35,
                  ),
                )),
      ),
    ),
  );
}

Shimmer shimmer() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ttb,
    enabled: true,
    baseColor: kGrey,
    highlightColor: Colors.white,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return const SkeletonCard();
      },
    ),
  );
}

bool pressed = false;
IconButton postIconButton(IconData icon1,
    {Function()? onPressed, color = kBlack}) {
  return IconButton(
    onPressed: onPressed,
    icon: Icon(
      icon1,
      size: 24,
      color: color,
    ),
  );
}

class CustomAlertDialogue extends StatelessWidget {
  final Text title;
  final Text content;
  final void Function() onPressed;

  const CustomAlertDialogue(
      {super.key,
      required this.title,
      required this.content,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Text("cancel")),
        IconButton(onPressed: onPressed, icon: const Text("ok")),
      ],
    );
  }
}

IconButton postDeleteIcon(BuildContext context, state, int index) {
  return IconButton(
    onPressed: () {
      showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 8,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                  // width: MediaQuery.sizeOf(context).width,

                  child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialogue(
                              title: const Text("Delete"),
                              content: const Text(
                                "Do you want to delete this post",
                              ),
                              onPressed: () {
                                if (editedList.contains(state.posts[index].id)) {
                                  editedList.remove(state.posts[index].id);
                                }
                                context.read<DeletePostBloc>().add(
                                    DeleteEvent(id: state.posts[index].id!));
                                navigatorPush(const PostDetailPage(), context);
                              });
                        }),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Delete  ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.delete)
                      ],
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () => navigatorPush(
                        EditPost(
                          post: state.posts[index],
                        ),
                        context),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Edit  ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Icon(Icons.edit)
                      ],
                    ),
                  ),
                ],
              )),
            ),
          );
        },
      );
    },
    icon: const Icon(Icons.more_horiz),
  );
}

TextButton logoutIcon(BuildContext context) {
  return TextButton.icon(
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
  );
}

logoutFunction(BuildContext context) {
  return showDialog(
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
}
